class Crumble::Material::ContextMenu
  getter icon_name : String
  getter label : String
  getter wrapper_attrs : WrapperAttrs

  def initialize(@icon_name = "MoreVert", @label = "More options", wrapper_attrs = WrapperAttrs.none)
    @wrapper_attrs = WrapperAttrs.from(wrapper_attrs)
  end

  css_class Wrapper
  css_class Trigger
  css_class Body

  ToHtml.instance_template do
    div Wrapper, ContextMenuController, ContextMenuController.close_on_outside_click_action("click@window"), ContextMenuController.close_on_escape_action("keydown@window"), wrapper_attrs do
      button Trigger, ContextMenuController.trigger_target, ContextMenuController.toggle_action("click"), type: "button", aria: {haspopup: "menu", expanded: false, label: label} do
        Icon.new(icon_name)
      end
      div Body, ContextMenuController.menu_target, ContextMenuController.close_on_selection_action("click"), role: "menu", tabindex: -1 do
        yield
      end
    end
  end

  style do
    layer LAYER_NAME do
      rule Wrapper do
        position :relative
        display :inline_block
      end

      rule Trigger do
        anchor_name :context_menu
        padding 0
      end

      rule Body do
        display :none
        # The static absolute position remains usable without anchors, so mobile browsers need no JavaScript geometry fallback.
        position :absolute
        z_index 1
        min_width 160.px
        padding 8.px, 0
        background_color :white
        box_shadow 1.px, 1.px, 3.px, "#000"
        position_anchor :context_menu
        position_area :block_end, :span_inline_start
        position_try_fallbacks :flip_block, :flip_inline
      end

      rule Body && Classes::MenuActive do
        display :block
      end
    end
  end
end
