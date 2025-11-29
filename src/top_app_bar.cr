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

  css_id TopAppBarId
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
      display :flex
      justify_content :space_between
      align_items :center
      padding 0, 16.px
      box_sizing :border_box
      column_gap 24.px
    end

    rule SmallType > h1 do
      flex_grow 2
    end

    rule LeadingIcon do
      width 24.px
      height 24.px
    end

    rule TopAppBarId > h1 do
      margin 0
      padding 0
      font_size 22.pt
      font_weight 400
      text_overflow :ellipsis
      overflow :hidden
      white_space :nowrap
    end

    rule TrailingIcons do
      min_width 24.px
      white_space :nowrap
      flex_shrink 0
    end

    rule TrailingIcon do
      display :inline_block
      width 24.px
      height 24.px
      margin_left 4.px
    end
  end

  def type_class
    case type
    in Type::CenterAligned then CenterAlignedType
    in Type::Small then SmallType
    end
  end
end
