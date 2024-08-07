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
          <link rel="stylesheet" href="/styles/crumble__material__layout__style_e7551bb0144f625fa816f071dff0c29a.css">
          <link rel="stylesheet" href="/styles/crumble__material__top_app_bar__style_7653341705e0b7f841cd3853d2c16741.css">
          <script type="module" src="/assets/stimulus_controllers_d3c864485a9fd2e3c6dc33375b54f5d3.js"></script>
        </head>
        <body data-controller="crumble--material--menu">
          <nav id="crumble--material--element-ids--menu" data-crumble--material--menu-target="menu">
            <div id="crumble--material--element-ids--drawer-header">
              <a class="crumble--material--classes--menu-switch" data-action="click->crumble--material--menu#switch" href="#">Switch</a>
            </div>
            <ul>
              <li><a href="https://www.example.com/this">This</a></li>
              <li><a href="https://www.example.com/is">Is</a></li>
              <li><a href="https://www.example.com/sparta">Sparta</a></li>
            </ul>
          </nav>
          <div class="crumble--material--classes--content">
            <nav id="crumble--material--top-app-bar--top-app-bar-id">
              <div class="crumble--material--top-app-bar--leading-icon">
                <a class="crumble--material--classes--menu-switch" data-action="click->crumble--material--menu#switch" href="#">Switch</a>
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
