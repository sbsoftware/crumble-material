class Crumble::Material::Card
  getter link_target : String?

  def initialize(@link_target = nil); end

  css_class Card
  css_class Link

  style do
    rule Card do
      position :relative
      padding 16.px
      box_shadow 1.px, 1.px, 3.px, "#000"
      width 376.px
      property("max-width", "calc(100vw - 32px)")
      min_height 100.px
      box_sizing :border_box
      margin_bottom 16.px
    end

    rule Link do
      position :absolute
      top 0.px
      left 0.px
      width 100.percent
      height 100.percent
      text_decoration :none
      z_index 1
    end
  end

  ToHtml.instance_template do
    div Card do
      a Link, href: link_target if link_target
      yield
    end
  end
end
