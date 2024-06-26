class Crumble::Material::TopAppBar(L, H, T)
  getter leading_icon : L?
  getter headline : H?
  getter trailing_icons : Array(T) | Array(Nil)

  def initialize(@leading_icon, @headline, @trailing_icons); end

  element_id TopAppBarId
  css_class LeadingIcon
  css_class TrailingIcons

  ToHtml.instance_template do
    nav TopAppBarId do
      div LeadingIcon do
        leading_icon
      end
      h1 do
        headline
      end
      div TrailingIcons do
        trailing_icons.each do |trailing_icon|
          trailing_icon
        end
      end
    end
  end

  style do
    rule TopAppBarId do
      width 100.percent
      height 64.px
      display Flex
      justifyContent SpaceBetween
      alignItems Center
      padding 0, 16.px
      prop("box-sizing", "border-box")
      prop("column-gap", 24.px)
    end

    rule LeadingIcon do
      width 24.px
      height 24.px
    end

    rule h1 do
      margin 0
      padding 0
      flexGrow 2
      fontSize "22pt"
      prop("font-weight", "400")
    end
  end
end
