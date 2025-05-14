require "./card"

class Crumble::Material::Card::SecondaryText
  css_class Text

  style do
    rule Text do
      color({0x88, 0x88, 0x88})
      prop("line-height", 28.px)
      marginTop 8.px
    end
  end

  ToHtml.instance_template do
    div Text do
      yield
    end
  end
end
