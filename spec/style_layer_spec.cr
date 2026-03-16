require "./spec_helper"

private macro material_stylesheets
  [
    {% for stylesheet in [Crumble::Material::Style, Crumble::Material::Icon::Style, Crumble::Material::ListItem::Style, Crumble::Material::NavigationDrawer::Style, Crumble::Material::TopAppBar::Style, Crumble::Material::Card::Style, Crumble::Material::Card::Title::Style, Crumble::Material::Card::SecondaryText::Style] %}
      {% for constant in stylesheet.resolve.constants %}
        {% if constant.stringify.starts_with?("LayerStyle") %}
          {{stylesheet}}::{{constant}},
        {% end %}
      {% end %}
    {% end %}
  ] of CSS::LayerStylesheet.class
end

describe "material stylesheet layers" do
  it "uses the crumble-material layer for every emitted stylesheet" do
    material_stylesheets.size.should eq(8)

    material_stylesheets.each do |stylesheet|
      stylesheet.layer_name.should eq("crumble-material")
    end
  end
end
