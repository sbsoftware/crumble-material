module Crumble
  module Material
    class ListItem
      css_class Item
      getter wrapper_attrs : WrapperAttrs

      def initialize(wrapper_attrs = WrapperAttrs.none)
        @wrapper_attrs = WrapperAttrs.from(wrapper_attrs)
      end

      ToHtml.instance_template do
        div Item, wrapper_attrs do
          yield
        end
      end

      def self.to_html(io, indent_level = 0)
        new.to_html(io, indent_level)
      end

      def self.to_html
        new.to_html
      end

      def self.to_html(&)
        new.to_html do |inner_io, indent_level|
          yield inner_io, indent_level
        end
      end

      material_style do
        rule Item do
          width 100.percent
          font_size 1.25.em
          line_height 40.px
          padding 8.px, 16.px
          border 1.px, :solid, "#BBBBBB"
          box_sizing :border_box
        end
      end
    end
  end
end
