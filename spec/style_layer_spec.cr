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
  ] of CSS::Stylesheet.class
end

describe "material stylesheet layers" do
  it "wraps every emitted stylesheet in the crumble-material layer" do
    material_stylesheets.each do |stylesheet|
      stylesheet.to_s.starts_with?("@layer crumble-material {\n").should be_true
      stylesheet.to_s.ends_with?("\n}").should be_true
      stylesheet.to_s.scan(/@layer crumble-material \{/).size.should eq(1)
    end
  end

  it "keeps the base stylesheet content inside the layer" do
    expected = <<-CSS
    @layer crumble-material {
    @font-face {
      font-family: "Roboto";
      src: url("#{Crumble::Material::RobotoRegular.uri_path}");
    }

    html, body, .crumble--material--classes--content {
      width: 100%;
    }

    html, body, .crumble--material--classes--content {
      min-height: 100vh;
      padding: 0;
      margin: 0;
    }

    body {
      display: flex;
      align-items: stretch;
    }

    body, button, input {
      font-family: "Roboto", sans-serif;
    }

    a {
      color: black;
      text-decoration: none;
    }

    [data-action]:not(input) {
      cursor: pointer;
    }

    input[type="text"], input[type="number"] {
      border: none;
      border-bottom: 1px solid black;
      background-color: #EEE;
      padding: 8px;
      box-sizing: border-box;
    }

    button {
      border: none;
      outline: none;
      background-color: transparent;
    }
    }
    CSS

    Crumble::Material::Style.to_s.should eq(expected)
  end

  it "keeps component stylesheet content inside the layer" do
    expected = <<-CSS
    @layer crumble-material {
    .crumble--material--card--card {
      position: relative;
      padding: 16px;
      box-shadow: 1px 1px 3px #000;
      width: 376px;
      max-width: calc(100vw - 32px);
      min-height: 100px;
      box-sizing: border-box;
      margin-bottom: 16px;
    }

    .crumble--material--card--link {
      position: absolute;
      top: 0px;
      left: 0px;
      width: 100%;
      height: 100%;
      text-decoration: none;
      z-index: 1;
    }
    }
    CSS

    Crumble::Material::Card::Style.to_s.should eq(expected)
  end
end
