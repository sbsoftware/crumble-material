require "./spec_helper"

private def material_stylesheets
  [
    Crumble::Material::Style,
    Crumble::Material::Icon::Style,
    Crumble::Material::ListItem::Style,
    Crumble::Material::NavigationDrawer::Style,
    Crumble::Material::TopAppBar::Style,
    Crumble::Material::Card::Style,
    Crumble::Material::Card::Title::Style,
    Crumble::Material::Card::SecondaryText::Style,
  ] of CSS::LayerStylesheet.class
end

describe "material stylesheet layers" do
  it "uses the crumble-material layer for every emitted stylesheet" do
    material_stylesheets.each do |stylesheet|
      stylesheet.layer_name.should eq("crumble-material")
    end
  end
end
