require "../spec_helper"

module Crumble::Material::Layout::ContextualActionsSpec
  class MyLayout < Crumble::Material::Layout
    def contextual_actions
      [MyXAction.new, MyYAction.new]
    end
  end

  class MyXAction
    ToHtml.instance_template do
      div { "X" }
    end
  end

  class MyYAction
    ToHtml.instance_template do
      div { "Y" }
    end
  end

  describe "MyLayout#to_html" do
    it "should return the correct HTML" do
      ctx = Crumble::Server::TestRequestContext.new
      layout = MyLayout.new(ctx)

      expected = <<-HTML.squish
      <!DOCTYPE html>
      <html>
        <head>
          <title></title>
          <meta charset="utf-8" name="viewport" content="width=device-width, initial-scale=1.0">
          <link rel="stylesheet" href="/styles/crumble__material__layout__style_a0060aaed13c4e0c31f0c457d2ce4daf.css">
          <script type="module" src="/assets/stimulus_controllers_a034199809fe026eec996c78f52dadb9.js"></script>
        </head>
        <body data-controller="crumble--material--menu">
          <nav id="crumble--material--element-ids--menu" data-crumble--material--menu-target="menu">
            <div id="crumble--material--element-ids--drawer-header">
              <a class="crumble--material--classes--menu-switch" data-action="click->crumble--material--menu#switch" href="#">Switch</a>
            </div>
            <ul></ul>
          </nav>
          <div class="crumble--material--classes--content">
            <header id="crumble--material--element-ids--top-app-bar">
              <a class="crumble--material--classes--menu-switch" data-action="click->crumble--material--menu#switch" href="#">Switch</a>
              <div>X</div>
              <div>Y</div>
            </header>
          </div>
        </body>
      </html>
      HTML

      layout.to_html do
        nil
      end.should eq(expected)
    end
  end
end
