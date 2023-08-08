class Crumble::Material::Layout < Template
  property window_title : String?

  template do
    doctype html
    html do
      head do
        title { window_title }
        meta Charset::UTF8, MetaName::Viewport, {"content", "width=device-width, initial-scale=1.0"}
        style Style
        stylesheets.each do |stylesheet|
          style stylesheet
        end
        scripts.each do |js_file|
          script js_file
        end
        inline_scripts.each do |_script|
          script do
            _script
          end
        end
        stimulus_include stimulus_includes if stimulus_includes
      end
      body(MenuController, body_controllers) do
        nav ElementIds::Menu, MenuController.menu_target do
          div ElementIds::DrawerHeader do
            menu_switch
          end
          ul do
            drawer_items.each do |item|
              li { item }
            end
          end
        end
        div Classes::Content do
          header ElementIds::TopAppBar do
            menu_switch
            page_title
          end
          main_docking_point
        end
      end
    end
  end

  template menu_switch do
    a Classes::MenuSwitch, href("#"), MenuController.switch_action(ClickEvent) do
      "Switch"
    end
  end

  def page_title
    nil
  end

  def stylesheets
    [] of CSS::Stylesheet.class
  end

  def scripts
    [] of JavascriptFile
  end

  def inline_scripts
    [] of String
  end

  def body_controllers
    [] of StimulusController.class
  end

  def stimulus_includes
    nil
  end

  def drawer_items
    [] of String
  end
end
