require "./card"

class Crumble::Material::Card::SecondaryText
  css_class Text

  style do
    rule Text do
      color rgb(0x88, 0x88, 0x88)
      line_height 28.px
      margin_top 8.px
    end
  end

  ToHtml.instance_template do
    div Text do
      yield
    end
  end
end
