class Crumble::Material::ContextMenu
  css_class Wrapper
  css_class Trigger
  css_class Body
  css_class MenuActive

  stimulus_controller MenuController do
    targets :trigger, :menu

    action "toggle" do |event|
      event.preventDefault._call
      this.menuTarget.classList.toggle(MenuActive.to_s.to_js_ref)
      open = this.menuTarget.classList.contains(MenuActive.to_s.to_js_ref)
      this.triggerTarget.setAttribute("aria-expanded", open)
      this.menuTarget.focus._call if open
    end

    action "close_on_outside_click" do |event|
      if this.element.contains(event.target) == false
        this.menuTarget.classList.remove(MenuActive.to_s.to_js_ref)
        this.triggerTarget.setAttribute("aria-expanded", false)
      end
    end

    action "close_on_escape" do |event|
      if event.key == "Escape" && this.menuTarget.classList.contains(MenuActive.to_s.to_js_ref)
        this.menuTarget.classList.remove(MenuActive.to_s.to_js_ref)
        this.triggerTarget.setAttribute("aria-expanded", false)
        this.triggerTarget.focus._call
      end
    end

    action "close_on_selection" do
      this.menuTarget.classList.remove(MenuActive.to_s.to_js_ref)
      this.triggerTarget.setAttribute("aria-expanded", false)
    end
  end

  getter icon_name : String
  getter label : String
  getter wrapper_attrs : WrapperAttrs

  def initialize(@icon_name = "MoreVert", @label = "More options", wrapper_attrs = WrapperAttrs.none)
    @wrapper_attrs = WrapperAttrs.from(wrapper_attrs)
  end

  ToHtml.instance_template do
    div Wrapper, MenuController, MenuController.close_on_outside_click_action("click@window"), MenuController.close_on_escape_action("keydown@window"), wrapper_attrs do
      button Trigger, MenuController.trigger_target, MenuController.toggle_action("click"), type: "button", aria: {haspopup: "menu", expanded: false, label: label} do
        Icon.new(icon_name)
      end
      div Body, MenuController.menu_target, MenuController.close_on_selection_action("click"), role: "menu", tabindex: -1 do
        yield
      end
    end
  end

  style do
    layer LAYER_NAME do
      rule Wrapper do
        position :relative
        display :inline_block
        # Scope the reusable anchor name so each menu resolves its own trigger.
        property "anchor-scope", "--context-menu"
      end

      rule Trigger do
        anchor_name :context_menu
        padding 0
      end

      rule Body do
        display :none
        # Explicit logical insets provide a predictable LTR/RTL fallback when anchor positioning is unavailable.
        position :absolute
        inset_block_start 100.percent
        inset_inline_end 0
        z_index 1
        min_inline_size min(160.px, calc(100.vw - 16.px))
        max_inline_size calc(100.vw - 16.px)
        max_block_size calc(100.vh - 16.px)
        overflow :auto
        padding 8.px, 0
        background_color :white
        box_shadow 1.px, 1.px, 3.px, "#000"
      end

      supports raw("((anchor-name: --context-menu) and (anchor-scope: --context-menu))") do
        rule Body do
          # A fixed positioned box uses the viewport for fit checks instead of the trigger-sized wrapper.
          position :fixed
          inset_block_start :auto
          inset_inline_end :auto
          position_anchor :context_menu
          position_area :block_end, :span_inline_start
          property "position-try-fallbacks", "flip-block, flip-inline, flip-block flip-inline"
          position_try_order :most_block_size
        end
      end

      rule Body && MenuActive do
        display :block
      end
    end
  end
end
