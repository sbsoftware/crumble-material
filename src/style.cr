require "./element_ids"
require "./classes"

class TTFFile < AssetFile
  def mime_type
    "font/ttf"
  end
end

RobotoRegular = TTFFile.register "assets/fonts/Roboto/Roboto-Regular.ttf", "#{__DIR__}/../assets/fonts/Roboto/Roboto-Regular.ttf"

class Crumble::Material::Style < CSS::Stylesheet
  rules do
    font_face do
      fontFamily "Roboto"
      fontStyle Normal
      src url(RobotoRegular.uri_path)
    end

    rule html, body, Classes::Content do
      width 100.percent
    end

    rule html, body, Classes::Content do
      minHeight 100.vh
      padding 0
      margin 0
    end

    rule body do
      display Flex
      alignItems Stretch
    end

    rule body, button, input do
      fontFamily "Roboto, sans-serif"
    end

    rule a do
      color Black
      textDecoration None
    end

    rule "[data-action]:not(input)" do
      prop("cursor", "pointer")
    end

    rule "input[type=\"text\"]", "input[type=\"number\"]" do
      prop("border", "none")
      prop("border-bottom", "1px solid black")
      backgroundColor "#EEE"
      padding 8.px
      prop("box-sizing", "border-box")
    end

    rule button do
      prop("border", "none")
      prop("outset", "none")
      backgroundColor "transparent"
    end
  end
end
