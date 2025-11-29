require "./element_ids"
require "./classes"

class TTFFile < AssetFile
  def mime_type
    "font/ttf"
  end
end

module Crumble::Material
  RobotoRegular = TTFFile.register "assets/fonts/Roboto/Roboto-Regular.ttf", "#{__DIR__}/../assets/fonts/Roboto/Roboto-Regular.ttf"

  style do
    font_face RobotoFont, name: "Roboto" do
      src url(RobotoRegular.uri_path)
    end

    rule html, body, Classes::Content do
      width 100.percent
    end

    rule html, body, Classes::Content do
      min_height 100.vh
      padding 0
      margin 0
    end

    rule body do
      display :flex
      align_items :stretch
    end

    rule body, button, input do
      font_family RobotoFont, :sans_serif
    end

    rule a do
      color :black
      text_decoration :none
    end

    rule "[data-action]:not(input)" do
      cursor :pointer
    end

    rule "input[type=\"text\"]", "input[type=\"number\"]" do
      border :none
      border_bottom 1.px, :solid, :black
      background_color "#EEE"
      padding 8.px
      box_sizing :border_box
    end

    rule button do
      border :none
      outline :none
      background_color :transparent
    end
  end
end
