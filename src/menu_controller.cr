class Crumble::Material::MenuController < Stimulus::Controller
  targets :menu

  action "switch" do |event|
    event.preventDefault._call
    this.menuTarget.classList.toggle(Classes::MenuActive.to_js_ref)
  end
end
