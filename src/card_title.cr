require "./card"

class Crumble::Material::Card::Title(T)
  getter text : T

  def initialize(@text); end

  css_class CardTitle

  style do
    rule CardTitle do
      margin 0
      font_size 24.px
      line_height 24.px
    end
  end

  ToHtml.instance_template do
    h3 CardTitle do
      text
    end
  end
end
