class Crumble::Material::NavigationDrawer(H, I)
  getter headline : H?
  getter items : Array(I) | Array(Nil)
  getter wrapper_attrs : WrapperAttrs

  def initialize(@headline, @items, wrapper_attrs = WrapperAttrs.none)
    @wrapper_attrs = WrapperAttrs.from(wrapper_attrs)
  end

  css_id Id
  css_class Items

  ToHtml.instance_template do
    nav Id, MenuController.menu_target, wrapper_attrs do
      h1 do
        headline
      end
      ul Items do
        items.each do |item|
          li do
            item
          end
        end
      end
    end
  end

  style do
    layer LAYER_NAME do
      rule Id do
        display :none
        width 360.px
        padding_top 16.px
      end

      rule Id && Classes::MenuActive do
        display :block
      end

      rule Id > a do
        text_decoration :none
        color :black
      end

      rule Items do
        list_style :none
        margin 0
        padding 0
      end

      rule(Id > h1, Items > any) do
        height 56.px
        margin 0, 28.px
        font_size 14.pt
        font_weight 500
      end
    end
  end

  class MenuSwitch
    getter wrapper_attrs : WrapperAttrs

    def initialize(wrapper_attrs = WrapperAttrs.none)
      @wrapper_attrs = WrapperAttrs.from(wrapper_attrs)
    end

    ToHtml.instance_template do
      span MenuController.switch_action("click"), wrapper_attrs do
        Crumble::Material::Icon.new("Menu")
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
  end
end
