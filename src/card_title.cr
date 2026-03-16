require "./card"

class Crumble::Material::Card::Title(T)
  getter text : T
  getter wrapper_attrs : WrapperAttrs

  def initialize(@text, wrapper_attrs = WrapperAttrs.none)
    @wrapper_attrs = WrapperAttrs.from(wrapper_attrs)
  end

  css_class CardTitle

  style do
    layer LAYER_NAME do
      rule CardTitle do
        margin 0
        font_size 24.px
        line_height 24.px
      end
    end
  end

  ToHtml.instance_template do
    h3 CardTitle, wrapper_attrs do
      text
    end
  end
end
