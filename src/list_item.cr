module Crumble
  module Material
    class ListItem
      css_class Item

      ToHtml.class_template do
        div Item do
          yield
        end
      end

      style do
        rule Item do
          width 100.percent
          fontSize 1.25.em
          prop("line-height", 40.px)
          padding 8.px, 16.px
          border 1.px, Solid, "#BBBBBB"
          prop("box-sizing", "border-box")
        end
      end
    end
  end
end
