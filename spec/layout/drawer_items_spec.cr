require "../spec_helper"

module Crumble::Material::Layout::DrawerItemsSpec
  class MyLayout < Crumble::Material::Layout
    getter my_model : MyModel

    def initialize(@my_model)
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
      layout = MyLayout.new(model)

      expected = <<-HTML.squish
      <!DOCTYPE html>
      <html>
        <head>
          <title></title>
          <meta charset="utf-8" name="viewport" content="width=device-width, initial-scale=1.0">
          <link rel="stylesheet" href="/styles/crumble__material__layout__style_a0060aaed13c4e0c31f0c457d2ce4daf.css">
          <script type="module" src="/assets/stimulus_controllers_6bd2fd0920cf4bb3b70ea896ede8e25f.js"></script>
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
            <header id="crumble--material--element-ids--top-app-bar">
              <a class="crumble--material--classes--menu-switch" data-action="click->crumble--material--menu#switch" href="#">Switch</a>
            </header>
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
