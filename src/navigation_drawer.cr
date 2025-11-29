class Crumble::Material::NavigationDrawer(H, I)
  getter headline : H?
  getter items : Array(I) | Array(Nil)

  def initialize(@headline, @items); end

  css_id Id
  css_class Items

  ToHtml.instance_template do
    nav Id, MenuController.menu_target do
      h1 do
        headline
      end
      ul Items do
        items.each do |item|
          li do
            item
          end
        end
      end
    end
  end

  style do
    rule Id do
      display :none
      width 360.px
      padding_top 16.px
    end

    rule Id && Classes::MenuActive do
      display :block
    end

    rule Id > a do
      text_decoration :none
      color :black
    end

    rule Items do
      list_style :none
      margin 0
      padding 0
    end

    rule(Id > h1, Items > any) do
      height 56.px
      margin 0, 28.px
      font_size 14.pt
      font_weight 500
    end
  end

  class MenuSwitch
    ToHtml.class_template do
      span MenuController.switch_action("click") do
        Crumble::Material::Icon.new("Menu")
      end
    end
  end
end
