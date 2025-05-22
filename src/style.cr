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
      fontFamily "Roboto, sans-serif"
    end

    rule body do
      display Flex
      alignItems Stretch
    end
  end
end
