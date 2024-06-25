require "./top_app_bar"

class Crumble::Material::Layout < Crumble::ContextView
  template do
    doctype html
    html do
      head do
        title { window_title }
        meta charset: "utf-8", name: "viewport", content: "width=device-width, initial-scale=1.0"
        link Style
        link TopAppBar::Style
        stylesheets.each do |stylesheet|
          link stylesheet
        end
        external_scripts.each do |external_script_url|
          script src: external_script_url
        end
        scripts.each do |js_file|
          script js_file
        end
        inline_scripts.each do |_script|
          script do
            _script
          end
        end
        script Crumble::StimulusControllers
      end
      body(MenuController, body_controllers) do
        nav ElementIds::Menu, MenuController.menu_target do
          div ElementIds::DrawerHeader do
            MenuSwitch
          end
          ul do
            drawer_items.each do |item|
              li { item }
            end
          end
        end
        div Classes::Content do
          top_app_bar

          yield
        end
      end
    end
  end

  class MenuSwitch
    ToHtml.class_template do
      a Classes::MenuSwitch, MenuController.switch_action("click"), href: "#" do
        "Switch"
      end
    end
  end

  def top_app_bar
    Crumble::Material::TopAppBar.new(
      leading_icon: MenuSwitch,
      headline: headline,
      trailing_icons: contextual_actions || [] of Nil
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

  def drawer_items
    [] of String
  end
end
