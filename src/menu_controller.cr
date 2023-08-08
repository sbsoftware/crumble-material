class Crumble::Material::MenuController < StimulusController
  targets :menu

  method "switch" do
    this.menuTarget.classList.toggle(Classes::MenuActive)
  end
end
