require "../spec_helper"

module Crumble::Material::Layout::ContextualActionsSpec
  class MyLayout < Crumble::Material::Layout
    def contextual_actions
      [MyXAction.new, MyYAction.new]
    end
  end

  class MyXAction < Template
    template do
      div { "X" }
    end
  end

  class MyYAction < Template
    template do
      div { "Y" }
    end
  end

  describe "MyLayout#to_s" do
    it "should return the correct HTML" do
      layout = MyLayout.new

      expected = <<-HTML
      <!doctype html>
      <html><head><title></title>
      <meta charset="utf-8" name="viewport" content="width=device-width, initial-scale=1.0"><link rel="stylesheet" href="/styles/crumble__material__layout__style_a0060aaed13c4e0c31f0c457d2ce4daf.css"></head>
      <body data-controller="crumble--material--menu"><nav id="crumble--material--element-ids--menu" data-crumble--material--menu-target="menu"><div id="crumble--material--element-ids--drawer-header"><a class="crumble--material--classes--menu-switch" href="#" data-action="click->crumble--material--menu#switch">Switch</a>
      </div>
      <ul></ul>
      </nav>
      <div class="crumble--material--classes--content"><header id="crumble--material--element-ids--top-app-bar"><a class="crumble--material--classes--menu-switch" href="#" data-action="click->crumble--material--menu#switch">Switch</a>
      <div>X</div>
      <div>Y</div>
      </header>
      </div>
      </body>
      </html>

      HTML

      layout.to_s.should eq(expected)
    end
  end
end
