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
      layout = MyLayout.new(ctx: ctx)

      expected = <<-HTML.squish
      <!DOCTYPE html>
      <html>
        <head>
          <title></title>
          <meta charset="utf-8" name="viewport" content="width=device-width, initial-scale=1.0">
          <script type="module" src="/assets/stimulus_controllers_4ca7ddc4ead535d3f689dc3ca433817f.js"></script>
          <link rel="stylesheet" href="/styles/crumble__material__style_bf76d411cbc83f5548e61e619e32dce0.css">
          <link rel="stylesheet" href="/styles/crumble__material__navigation_drawer__style_0f7e9c5372499b61335448ccaa0d639d.css">
          <link rel="stylesheet" href="/styles/crumble__material__top_app_bar__style_c1b72eb45f3fcc455f1c97cf085b758a.css">
          <link rel="stylesheet" href="/styles/crumble__material__card__style_2d37f487832f6d1c71d132a44fd141ef.css">
          <link rel="stylesheet" href="/styles/crumble__material__card__title__style_7b8235f5cf026a2cf8d44e214bd75988.css">
          <link rel="stylesheet" href="/styles/crumble__material__card__secondary_text__style_d803fa0a99bc7bbff49f299919ad1ac2.css">
        </head>
        <body data-controller="crumble--material--menu">
          <nav id="crumble--material--navigation-drawer--id" data-crumble--material--menu-target="menu">
            <h1></h1>
            <ul class="crumble--material--navigation-drawer--items"></ul>
          </nav>
          <div class="crumble--material--classes--content">
            <nav id="crumble--material--top-app-bar--top-app-bar-id" class="crumble--material--top-app-bar--center-aligned-type">
              <div class="crumble--material--top-app-bar--leading-icon">
                <span class="crumble--material--classes--material-icon" data-action="click->crumble--material--menu#switch">Menu</span>
              </div>
              <h1></h1>
              <div class="crumble--material--top-app-bar--trailing-icons">
                <div class="crumble--material--top-app-bar--trailing-icon">
                  <div>X</div>
                </div>
                <div class="crumble--material--top-app-bar--trailing-icon">
                  <div>Y</div>
                </div>
              </div>
            </nav>
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
