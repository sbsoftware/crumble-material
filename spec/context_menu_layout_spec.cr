require "./spec_helper"
require "file_utils"
require "json"

module Crumble::Material::ContextMenuLayoutSpec
  WRAPPER  = "crumble--material--context-menu--wrapper"
  TRIGGER  = "crumble--material--context-menu--trigger"
  BODY     = "crumble--material--context-menu--body"
  ACTIVE   = "crumble--material--context-menu--menu-active"
  CHROMIUM = ENV["CHROMIUM"]?

  private def self.render_layout(*, anchors = true, width = 320, height = 240)
    css = ContextMenu::Style.to_s
    unless anchors
      start = css.index("  @supports ((anchor-name: --context-menu) and (anchor-scope: --context-menu))").not_nil!
      finish = css.index("\n\n  .#{BODY}.#{ACTIVE}", start).not_nil!
      css = css[0, start] + css[finish..]
    end

    html = <<-HTML
      <!doctype html><meta name="viewport" content="width=device-width"><style>
      #{css}
      * { box-sizing: border-box; }
      html, body { margin: 0; width: 100%; height: 100%; }
      .fixture { position: fixed; width: 24px; height: 24px; }
      .fixture button { width: 24px; height: 24px; }
      .left { inset: 8px auto auto 0; }
      .right { inset: 8px 0 auto auto; }
      .bottom { inset: auto 0 0 auto; }
      .first { inset: 72px auto auto 200px; }
      .second { inset: 104px 24px auto auto; }
      .rtl { direction: rtl; inset: 40px auto auto 0; }
      .tall { inset: auto auto 0 120px; }
      .#{BODY} { font: 16px sans-serif; }
      .#{BODY} > div { block-size: 32px; white-space: nowrap; }
      </style>
      <div id="left" class="fixture left #{WRAPPER}"><button class="#{TRIGGER}"></button><div class="#{BODY} #{ACTIVE}"><div>Long action label near the left edge</div></div></div>
      <div id="right" class="fixture right #{WRAPPER}"><button class="#{TRIGGER}"></button><div class="#{BODY} #{ACTIVE}"><div>Right</div></div></div>
      <div id="bottom" class="fixture bottom #{WRAPPER}"><button class="#{TRIGGER}"></button><div class="#{BODY} #{ACTIVE}"><div>Bottom</div><div>Reachable</div></div></div>
      <div id="first" class="fixture first #{WRAPPER}"><button class="#{TRIGGER}"></button><div class="#{BODY} #{ACTIVE}"><div>First</div></div></div>
      <div id="second" class="fixture second #{WRAPPER}"><button class="#{TRIGGER}"></button><div class="#{BODY} #{ACTIVE}"><div>Second</div></div></div>
      <div id="rtl" class="fixture rtl #{WRAPPER}" dir="rtl"><button class="#{TRIGGER}"></button><div class="#{BODY} #{ACTIVE}"><div>RTL action</div></div></div>
      <div id="tall" class="fixture tall #{WRAPPER}"><button class="#{TRIGGER}"></button><div class="#{BODY} #{ACTIVE}">#{(1..20).join { |i| "<div>Action #{i}</div>" }}</div></div>
      <pre id="result"></pre><script>
      const result = {viewport: {width: innerWidth, height: innerHeight}};
      const rect = element => { const value = element.getBoundingClientRect(); return {left: value.left, top: value.top, right: value.right, bottom: value.bottom, width: value.width, height: value.height}; };
      for (const id of ["left", "right", "bottom", "first", "second", "rtl", "tall"]) {
        const fixture = document.getElementById(id), trigger = fixture.querySelector("button"), menu = fixture.querySelector(".#{BODY}");
        result[id] = {trigger: rect(trigger), menu: rect(menu), clientHeight: menu.clientHeight, scrollHeight: menu.scrollHeight, position: getComputedStyle(menu).position};
      }
      const tallMenu = document.querySelector("#tall .#{BODY}");
      tallMenu.scrollTop = tallMenu.scrollHeight;
      result.tall.lastAction = rect(tallMenu.lastElementChild);
      document.getElementById("result").textContent = JSON.stringify(result);
      </script>
      HTML

    path = File.tempname("context-menu-layout", ".html")
    profile = File.tempname("context-menu-chromium")
    File.write(path, html)
    output = IO::Memory.new
    error = IO::Memory.new
    status = Process.run(CHROMIUM.not_nil!, ["--headless", "--no-sandbox", "--disable-gpu", "--window-size=#{width},#{height}", "--user-data-dir=#{profile}", "--dump-dom", "file://#{path}"], output: output, error: error)
    raise "Chromium layout test failed: #{error}" unless status.success?
    JSON.parse(output.to_s.match(/<pre id="result">(.*?)<\/pre>/).not_nil![1])
  ensure
    File.delete(path) if path && File.exists?(path)
    FileUtils.rm_rf(profile) if profile && Dir.exists?(profile)
  end

  private def self.assert_within_viewport(layout, id)
    menu = layout[id]["menu"]
    menu["left"].as_f.should be >= 0
    menu["top"].as_f.should be >= 0
    menu["right"].as_f.should be <= layout["viewport"]["width"].as_i
    menu["bottom"].as_f.should be <= layout["viewport"]["height"].as_i
  end

  # Browser layout specs are opt-in because Crystal's regular test environments do not necessarily provide Chromium.
  describe ContextMenu do
    it "keeps independently anchored LTR and RTL menus within narrow viewport edges" do
      layout = render_layout

      %w(left right bottom first second rtl tall).each { |id| assert_within_viewport(layout, id) }
      layout["left"]["position"].as_s.should eq("fixed")
      layout["first"]["menu"]["right"].as_f.should eq(layout["first"]["trigger"]["right"].as_f)
      layout["second"]["menu"]["right"].as_f.should eq(layout["second"]["trigger"]["right"].as_f)
      layout["rtl"]["menu"]["left"].as_f.should eq(layout["rtl"]["trigger"]["left"].as_f)
      layout["bottom"]["menu"]["bottom"].as_f.should be <= layout["bottom"]["trigger"]["top"].as_f
      layout["tall"]["clientHeight"].as_i.should be < layout["tall"]["scrollHeight"].as_i
      layout["tall"]["lastAction"]["top"].as_f.should be >= layout["tall"]["menu"]["top"].as_f
      layout["tall"]["lastAction"]["bottom"].as_f.should be <= layout["tall"]["menu"]["bottom"].as_f
    end

    it "keeps long labels within a viewport narrower than the default menu width" do
      layout = render_layout(width: 150, height: 180)

      assert_within_viewport(layout, "left")
      assert_within_viewport(layout, "right")
      layout["left"]["menu"]["width"].as_f.should be <= 134
    end

    it "provides explicit below-trigger logical positioning without anchor support" do
      layout = render_layout(anchors: false)

      layout["first"]["position"].as_s.should eq("absolute")
      layout["first"]["menu"]["top"].as_f.should eq(layout["first"]["trigger"]["bottom"].as_f)
      layout["first"]["menu"]["right"].as_f.should eq(layout["first"]["trigger"]["right"].as_f)
      layout["rtl"]["menu"]["top"].as_f.should eq(layout["rtl"]["trigger"]["bottom"].as_f)
      layout["rtl"]["menu"]["left"].as_f.should eq(layout["rtl"]["trigger"]["left"].as_f)
      assert_within_viewport(layout, "first")
      assert_within_viewport(layout, "rtl")
    end
  end if CHROMIUM
end
