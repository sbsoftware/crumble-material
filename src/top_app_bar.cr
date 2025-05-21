class Crumble::Material::TopAppBar(L, H, T)
  enum Type
    CenterAligned
    Small
  end

  getter leading_icon : L?
  getter headline : H?
  getter trailing_icons : Array(T) | Array(Nil)
  getter type : Type

  def initialize(@leading_icon, @headline, @trailing_icons, @type = :small); end

  element_id TopAppBarId
  css_class LeadingIcon
  css_class TrailingIcons
  css_class TrailingIcon
  css_class CenterAlignedType
  css_class SmallType

  ToHtml.instance_template do
    nav TopAppBarId, type_class do
      div LeadingIcon do
        leading_icon
      end
      h1 do
        headline
      end
      div TrailingIcons do
        trailing_icons.each do |trailing_icon|
          div TrailingIcon do
            trailing_icon
          end
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

    rule SmallType >> h1 do
      flexGrow 2
    end

    rule LeadingIcon do
      width 24.px
      height 24.px
    end

    rule TopAppBarId >> h1 do
      margin 0
      padding 0
      fontSize "22pt"
      prop("font-weight", "400")
      prop("text-overflow", "ellipsis")
      prop("overflow", "hidden")
      prop("white-space", "nowrap")
    end

    rule TrailingIcons do
      minWidth 24.px
      prop("white-space", "nowrap")
      prop("flex-shrink", 0)
    end

    rule TrailingIcon do
      display InlineBlock
      width 24.px
      height 24.px
      prop("margin-left", 4.px)
    end
  end

  def type_class
    case type
    in Type::CenterAligned then CenterAlignedType
    in Type::Small then SmallType
    end
  end
end
