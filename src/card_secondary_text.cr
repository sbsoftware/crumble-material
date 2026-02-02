require "./card"

class Crumble::Material::Card::SecondaryText
  css_class Text
  getter wrapper_attrs : WrapperAttrs

  def initialize(wrapper_attrs = WrapperAttrs.none)
    @wrapper_attrs = WrapperAttrs.from(wrapper_attrs)
  end

  style do
    rule Text do
      color rgb(0x88, 0x88, 0x88)
      line_height 28.px
      margin_top 8.px
    end
  end

  ToHtml.instance_template do
    div Text, wrapper_attrs do
      yield
    end
  end
end
