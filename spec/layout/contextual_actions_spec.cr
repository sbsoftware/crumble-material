require "../spec_helper"

module Crumble::Material::Layout::ContextualActionsSpec
  class MyLayout < Crumble::Material::Layout
    def contextual_actions
      [MyXAction.new, MyYAction.new]
    end
  end

  class MyXAction
    ToHtml.instance_template do
      div { "X" }
    end
  end

  class MyYAction
    ToHtml.instance_template do
      div { "Y" }
    end
  end

  describe "MyLayout#to_html" do
    it "should return the correct HTML" do
      ctx = test_handler_context
      layout = MyLayout.new(ctx: ctx)

      stimulus_uri = Crumble::StimulusControllers.uri_path
      icon_style = Crumble::Material::Icon::Style.uri_path
      list_item_style = Crumble::Material::ListItem::Style.uri_path
      base_style = Crumble::Material::Style.uri_path
      navigation_drawer_style = Crumble::Material::NavigationDrawer::Style.uri_path
      top_app_bar_style = Crumble::Material::TopAppBar::Style.uri_path
      card_style = Crumble::Material::Card::Style.uri_path
      card_title_style = Crumble::Material::Card::Title::Style.uri_path
      card_secondary_style = Crumble::Material::Card::SecondaryText::Style.uri_path

      expected = <<-HTML.squish
      <!DOCTYPE html>
      <html>
        <head>
          <title></title>
          <meta charset="utf-8" name="viewport" content="width=device-width, initial-scale=1.0">
          <script>var pageload_time;var evt_source;pageload_time = Date.now();evt_source = new EventSource("/live_reload");evt_source.addEventListener("message", function(msg) {var compile_time;compile_time = Date.parse(msg.data);if (pageload_time < compile_time) {window.location.reload();}});</script>
          <script type="module" src="#{stimulus_uri}"></script>
          <link rel="stylesheet" href="#{icon_style}">
          <link rel="stylesheet" href="#{list_item_style}">
          <link rel="stylesheet" href="#{base_style}">
          <link rel="stylesheet" href="#{navigation_drawer_style}">
          <link rel="stylesheet" href="#{top_app_bar_style}">
          <link rel="stylesheet" href="#{card_style}">
          <link rel="stylesheet" href="#{card_title_style}">
          <link rel="stylesheet" href="#{card_secondary_style}">
        </head>
        <body data-controller="crumble--material--menu">
          <nav id="crumble--material--navigation-drawer--id" data-crumble--material--menu-target="menu">
            <h1></h1>
            <ul class="crumble--material--navigation-drawer--items"></ul>
          </nav>
          <div class="crumble--material--classes--content">
            <nav id="crumble--material--top-app-bar--top-app-bar-id" class="crumble--material--top-app-bar--center-aligned-type">
              <div class="crumble--material--top-app-bar--leading-icon">
                <span data-action="click->crumble--material--menu#switch">
                  <div class="crumble--material--icon--wrapper">
                    <span class="crumble--material--icon--icon-class">Menu</span>
                  </div>
                </span>
              </div>
              <h1></h1>
              <div class="crumble--material--top-app-bar--trailing-icons">
                <div class="crumble--material--top-app-bar--trailing-icon">
                  <div>X</div>
                </div>
                <div class="crumble--material--top-app-bar--trailing-icon">
                  <div>Y</div>
                </div>
              </div>
            </nav>
          </div>
        </body>
      </html>
      HTML

      layout.to_html do
        nil
      end.should eq(expected)
    end
  end
end
