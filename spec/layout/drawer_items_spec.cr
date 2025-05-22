require "../spec_helper"

module Crumble::Material::Layout::DrawerItemsSpec
  class MyLayout < Crumble::Material::Layout
    getter my_model : MyModel

    def initialize(@ctx, @my_model)
    end

    def drawer_items
      my_model.menu_items.map do |item|
        MyDrawerItemView.new(item)
      end
    end
  end

  class MyDrawerItemView
    getter name : String

    def initialize(@name)
    end

    ToHtml.instance_template do
      a(href: "https://www.example.com/#{name.downcase}") { name }
    end
  end

  class MyView
    getter my_model : MyModel

    def initialize(@my_model)
    end

    ToHtml.instance_template do
      div { my_model.name }
    end
  end

  class MyModel
    getter name : String

    def initialize(@name)
    end

    def menu_items
      ["This", "Is", "Sparta"]
    end
  end

  describe "MyLayout#to_html" do
    it "should return the correct HTML" do
      model = MyModel.new("Hulk")
      ctx = Crumble::Server::TestRequestContext.new
      layout = MyLayout.new(ctx, model)

      expected = <<-HTML.squish
      <!DOCTYPE html>
      <html>
        <head>
          <title></title>
          <meta charset="utf-8" name="viewport" content="width=device-width, initial-scale=1.0">
          <script>var pageload_time;var evt_source;pageload_time = Date.now();evt_source = new EventSource("/live_reload");evt_source.addEventListener("message", function(msg) {var compile_time;compile_time = Date.parse(msg.data);if (pageload_time < compile_time) {window.location.reload();}});</script>
          <script type="module" src="/assets/stimulus_controllers_4ca7ddc4ead535d3f689dc3ca433817f.js"></script>
          <link rel="stylesheet" href="/styles/crumble__material__style_e7551bb0144f625fa816f071dff0c29a.css">
          <link rel="stylesheet" href="/styles/crumble__material__navigation_drawer__style_0f7e9c5372499b61335448ccaa0d639d.css">
          <link rel="stylesheet" href="/styles/crumble__material__top_app_bar__style_4a6b50c08af83370811367077c4e4f59.css">
          <link rel="stylesheet" href="/styles/crumble__material__card__style_2d37f487832f6d1c71d132a44fd141ef.css">
          <link rel="stylesheet" href="/styles/crumble__material__card__title__style_7b8235f5cf026a2cf8d44e214bd75988.css">
          <link rel="stylesheet" href="/styles/crumble__material__card__secondary_text__style_d803fa0a99bc7bbff49f299919ad1ac2.css">
          <link rel="stylesheet" href="/styles/crumble__material__icon__style_30d14c5ba82dad0fc4833259fd08b711.css">
        </head>
        <body data-controller="crumble--material--menu">
          <nav id="crumble--material--navigation-drawer--id" data-crumble--material--menu-target="menu">
            <h1></h1>
            <ul class="crumble--material--navigation-drawer--items">
              <li><a href="https://www.example.com/this">This</a></li>
              <li><a href="https://www.example.com/is">Is</a></li>
              <li><a href="https://www.example.com/sparta">Sparta</a></li>
            </ul>
          </nav>
          <div class="crumble--material--classes--content">
            <nav id="crumble--material--top-app-bar--top-app-bar-id" class="crumble--material--top-app-bar--center-aligned-type">
              <div class="crumble--material--top-app-bar--leading-icon">
                <span data-action="click->crumble--material--menu#switch">
                  <span class="crumble--material--icon--icon-class">Menu</span>
                </span>
              </div>
              <h1></h1>
              <div class="crumble--material--top-app-bar--trailing-icons"></div>
            </nav>
            <div>Hulk</div>
          </div>
        </body>
      </html>
      HTML

      layout.to_html do |io, indent_level|
        MyView.new(model).to_html(io, indent_level)
      end.should eq(expected)
    end
  end
end
