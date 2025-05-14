class Crumble::Material::Card
  getter link_target : String?

  def initialize(@link_target = nil); end

  css_class Card
  css_class Link

  style do
    rule Card do
      position Relative
      padding 16.px
      prop("box-shadow", "1px 1px 3px #000")
      width 376.px
      height 100.px
      maxWidth "calc(100vw - 32px)"
      prop("box-sizing", "border-box")
    end

    rule Link do
      position Absolute
      top 0.px
      left 0.px
      width 100.percent
      height 100.percent
      textDecoration None
      zIndex 1
    end
  end

  ToHtml.instance_template do
    div Card do
      a Link, href: link_target if link_target
      yield
    end
  end
end
