module Crumble
  module Material
    class Icon
      Font = TTFFile.register "assets/MaterialSymbolsOutlined.ttf", "#{__DIR__}/../assets/fonts/MaterialSymbolsOutlined/MaterialSymbolsOutlined.ttf"

      getter name : String

      def initialize(@name); end

      css_class IconClass

      ToHtml.instance_template do
        span IconClass do
          name
        end
      end

      style do
        font_face do
          fontFamily "Material Symbols Outlined"
          fontStyle Normal
          src url(Font.uri_path)
        end

        rule IconClass do
          fontFamily "Material Symbols Outlined"
          fontWeight Normal
          fontStyle Normal
          fontSize 24.px
          display InlineBlock
          prop("line-height", "1")
          textDecoration None
          prop("vertical-align", "text-bottom")
          # textTransform None
          # letterSpacing Normal
          # wordWrap Normal
          # whiteSpace NoWrap
          # direction LTR
        end
      end
    end
  end
end
