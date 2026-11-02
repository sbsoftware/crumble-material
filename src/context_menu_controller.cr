class Crumble::Material::ContextMenuController < Stimulus::Controller
  targets :trigger, :menu

  action "toggle" do |event|
    event.preventDefault._call
    this.menuTarget.classList.toggle("crumble--material--classes--menu-active")
    open = this.menuTarget.classList.contains("crumble--material--classes--menu-active")
    this.triggerTarget.setAttribute("aria-expanded", open)
    this.menuTarget.focus._call if open
  end

  action "close_on_outside_click" do |event|
    if this.element.contains(event.target) == false
      this.menuTarget.classList.remove("crumble--material--classes--menu-active")
      this.triggerTarget.setAttribute("aria-expanded", false)
    end
  end

  action "close_on_escape" do |event|
    if event.key == "Escape" && this.menuTarget.classList.contains("crumble--material--classes--menu-active")
      this.menuTarget.classList.remove("crumble--material--classes--menu-active")
      this.triggerTarget.setAttribute("aria-expanded", false)
      this.triggerTarget.focus._call
    end
  end

  action "close_on_selection" do
    this.menuTarget.classList.remove("crumble--material--classes--menu-active")
    this.triggerTarget.setAttribute("aria-expanded", false)
  end
end
