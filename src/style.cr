require "./element_ids"
require "./classes"

class TTFFile < AssetFile
  def mime_type
    "font/ttf"
  end
end

RobotoRegular = TTFFile.register "assets/fonts/Roboto/Roboto-Regular.ttf", "#{__DIR__}/../assets/fonts/Roboto/Roboto-Regular.ttf"
MaterialIconFont = TTFFile.register "assets/MaterialSymbolsOutlined.ttf", "#{__DIR__}/../assets/fonts/MaterialSymbolsOutlined/MaterialSymbolsOutlined.ttf"

class Crumble::Material::Layout::Style < CSS::Stylesheet
  rules do
    font_face do
      fontFamily "Roboto"
      fontStyle Normal
      src url(RobotoRegular.uri_path)
    end

    font_face do
      fontFamily "Material Symbols Outlined"
      fontStyle Normal
      src url(MaterialIconFont.uri_path)
    end

    rule Classes::MaterialIcon do
      fontFamily "Material Symbols Outlined"
      fontWeight Normal
      fontStyle Normal
      fontSize 24.px
      display InlineBlock
      prop("line-height", "1")
      # textTransform None
      # letterSpacing Normal
      # wordWrap Normal
      # whiteSpace NoWrap
      # direction LTR
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
