class Crumble::Material::NavigationDrawer(H, I)
  getter headline : H?
  getter items : Array(I) | Array(Nil)

  def initialize(@headline, @items); end

  element_id Id
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
      display None
      width 360.px
      paddingTop 16.px
    end

    rule Id & Classes::MenuActive do
      display Block
    end

    rule Id >> a do
      textDecoration None
      color Black
    end

    rule Items do
      listStyle None
      margin 0
      padding 0
    end

    rule(Id >> h1, Items > any) do
      height 56.px
      prop("margin", "0 28px")
      prop("font-size", "14pt")
      prop("font-weight", "500")
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
