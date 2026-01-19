require "./style"
require "./navigation_drawer"
require "./top_app_bar"
require "./card"
require "./card_title"
require "./card_secondary_text"
require "./menu_controller"

class Crumble::Material::Layout < ToHtml::Layout
  include Crumble::ContextView

  body_attributes Crumble::Material::MenuController

  template do
    super do
      navigation_drawer
      div Classes::Content do
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

  def window_title
    nil
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
