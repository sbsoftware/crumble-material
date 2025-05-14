require "./style"
require "./navigation_drawer"
require "./top_app_bar"
require "./card"
require "./card_title"
require "./card_secondary_text"
require "./menu_controller"

class Crumble::Material::Layout < ToHtml::Layout
  include Crumble::ContextView

  add_to_head Crumble::Material::Style
  add_to_head Crumble::Material::NavigationDrawer::Style
  add_to_head Crumble::Material::TopAppBar::Style
  add_to_head Crumble::Material::Card::Style, Crumble::Material::Card::Title::Style, Card::SecondaryText::Style

  body_attributes Crumble::Material::MenuController

  template do
    super do
      navigation_drawer
      div Classes::Content do
        top_app_bar

        yield
      end
    end
  end

  def navigation_drawer
    Crumble::Material::NavigationDrawer.new(
      headline: drawer_headline,
      items: drawer_items
    )
  end

  def top_app_bar
    Crumble::Material::TopAppBar.new(
      leading_icon: Crumble::Material::NavigationDrawer::MenuSwitch,
      headline: headline,
      trailing_icons: contextual_actions || [] of Nil,
      type: top_app_bar_type
    )
  end

  def window_title
    nil
  end

  def headline
    nil
  end

  def contextual_actions
    nil
  end

  def top_app_bar_type
    TopAppBar::Type::CenterAligned
  end

  def drawer_headline
    nil
  end

  def drawer_items
    [] of String
  end

  def stylesheets
    [] of CSS::Stylesheet.class
  end

  def external_scripts
    [] of String
  end

  def scripts
    [] of JavascriptFile
  end

  def inline_scripts
    [] of String
  end

  def body_controllers
    [] of ::Stimulus::Controller.class
  end
end
