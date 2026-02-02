require "./spec_helper"

module Crumble::Material::WrapperAttrsSpec
  class ExtraAttrs
    def self.to_html_attrs(_tag, attrs)
      attrs["class"] = "extra"
      attrs["data-role"] = "custom"
    end
  end

  describe "Wrapper attrs" do
    it "adds wrapper attrs to ListItem" do
      list_item = Crumble::Material::ListItem.new(ExtraAttrs)

      expected = "<div class=\"crumble--material--list-item--item extra\" data-role=\"custom\">Hello</div>"

      list_item.to_html do |io, _indent_level|
        io << "Hello"
      end.should eq(expected)
    end

    it "adds wrapper attrs to Card" do
      card = Crumble::Material::Card.new(link_target: nil, wrapper_attrs: ExtraAttrs)

      expected = "<div class=\"crumble--material--card--card extra\" data-role=\"custom\">Hello</div>"

      card.to_html do |io, _indent_level|
        io << "Hello"
      end.should eq(expected)
    end

    it "adds wrapper attrs to Icon" do
      icon = Crumble::Material::Icon.new("Menu", nil, wrapper_attrs: ExtraAttrs)

      expected = "<div class=\"crumble--material--icon--wrapper extra\" data-role=\"custom\"><span class=\"crumble--material--icon--icon-class\">Menu</span></div>"

      icon.to_html.should eq(expected)
    end

    it "adds wrapper attrs to Card::Title" do
      title = Crumble::Material::Card::Title.new("Hello", wrapper_attrs: ExtraAttrs)

      expected = "<h3 class=\"crumble--material--card--title--card-title extra\" data-role=\"custom\">Hello</h3>"

      title.to_html.should eq(expected)
    end

    it "adds wrapper attrs to Card::SecondaryText" do
      text = Crumble::Material::Card::SecondaryText.new(ExtraAttrs)

      expected = "<div class=\"crumble--material--card--secondary-text--text extra\" data-role=\"custom\">Body</div>"

      text.to_html do |io, _indent_level|
        io << "Body"
      end.should eq(expected)
    end

    it "adds wrapper attrs to TopAppBar" do
      app_bar = Crumble::Material::TopAppBar.new(
        leading_icon: nil,
        headline: "Headline",
        trailing_icons: [] of Nil,
        type: Crumble::Material::TopAppBar::Type::Small,
        wrapper_attrs: ExtraAttrs
      )

      expected = "<nav id=\"crumble--material--top-app-bar--top-app-bar-id\" class=\"crumble--material--top-app-bar--small-type extra\" data-role=\"custom\"><div class=\"crumble--material--top-app-bar--leading-icon\"></div><h1>Headline</h1><div class=\"crumble--material--top-app-bar--trailing-icons\"></div></nav>"

      app_bar.to_html.should eq(expected)
    end

    it "adds wrapper attrs to NavigationDrawer" do
      drawer = Crumble::Material::NavigationDrawer.new(
        headline: "Menu",
        items: [] of String,
        wrapper_attrs: ExtraAttrs
      )

      expected = "<nav id=\"crumble--material--navigation-drawer--id\" data-crumble--material--menu-target=\"menu\" class=\"extra\" data-role=\"custom\"><h1>Menu</h1><ul class=\"crumble--material--navigation-drawer--items\"></ul></nav>"

      drawer.to_html.should eq(expected)
    end

    it "adds wrapper attrs to MenuSwitch" do
      menu_switch = Crumble::Material::NavigationDrawer::MenuSwitch.new(ExtraAttrs)

      expected = "<span data-action=\"click->crumble--material--menu#switch\" class=\"extra\" data-role=\"custom\"><div class=\"crumble--material--icon--wrapper\"><span class=\"crumble--material--icon--icon-class\">Menu</span></div></span>"

      menu_switch.to_html.should eq(expected)
    end
  end
end
