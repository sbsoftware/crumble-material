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
      font_face MaterialSymbolsOutlinedFont, name: "Material Symbols Outlined" do
        src url(Font.uri_path)
      end

      rule Wrapper do
        display :inline_flex
        align_items :center
        vertical_align :text_bottom
      end

      rule IconClass do
        font_family MaterialSymbolsOutlinedFont
        font_weight :normal
        font_style :normal
        font_size 24.px
        display :inline_block
        line_height 1
        text_decoration :none
        vertical_align :text_bottom
        # textTransform None
        # letterSpacing Normal
        # wordWrap Normal
        # whiteSpace NoWrap
        # direction LTR
      end

      rule Caption do
        margin_left 2.px
      end
    end
  end
end
end
