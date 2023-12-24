class Crumble::Material::MenuController < Stimulus::Controller
  targets :menu

  action "switch" do
    this.menuTarget.classList.toggle(Classes::MenuActive)
  end
end
