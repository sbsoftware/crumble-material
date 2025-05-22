module Crumble
  module Material
    class Icon
      Font = TTFFile.register "assets/MaterialSymbolsOutlined.ttf", "#{__DIR__}/../assets/fonts/MaterialSymbolsOutlined/MaterialSymbolsOutlined.ttf"

      getter name : String
      getter caption_text : String?

      def initialize(@name, @caption_text = nil); end

      css_class Wrapper
      css_class IconClass
      css_class Caption

      ToHtml.instance_template do
        div Wrapper do
          span IconClass do
            name
          end
          if caption_text
            span Caption do
              caption_text
            end
          end
        end
      end

      style do
        font_face do
          fontFamily "Material Symbols Outlined"
          fontStyle Normal
          src url(Font.uri_path)
        end

        rule Wrapper do
          prop("display", "inline-flex")
          alignItems Center
          prop("vertical-align", "text-bottom")
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

        rule Caption do
          marginLeft 2.px
        end
      end
    end
  end
end
