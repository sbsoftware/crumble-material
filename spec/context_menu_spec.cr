require "./spec_helper"

module Crumble::Material::ContextMenuSpec
  class ExtraAttrs
    def self.to_html_attrs(_tag, attrs)
      attrs["data-test"] = "context-menu"
    end
  end

  describe ContextMenu do
    it "renders an accessible trigger and generic menu body" do
      menu = ContextMenu.new("MoreVert", "Contact actions", ExtraAttrs)

      html = menu.to_html do |io, _indent_level|
        io << %(<a href="/contacts/1/edit" data-action="contact#edit" role="menuitem">Edit</a>)
      end

      html.should contain(%(data-controller="crumble--material--context-menu"))
      html.should contain(%(data-action="click@window->crumble--material--context-menu#close_on_outside_click keydown@window->crumble--material--context-menu#close_on_escape"))
      html.should contain(%(data-test="context-menu"))
      html.should contain(%(aria-haspopup="menu" aria-expanded="false" aria-label="Contact actions"))
      html.should contain(%(data-crumble--material--context-menu-target="trigger"))
      html.should contain(%(role="menu" tabindex="-1"))
      html.should contain(%(<a href="/contacts/1/edit" data-action="contact#edit" role="menuitem">Edit</a>))
    end

    it "uses CSS anchor positioning with browser-selected fallbacks" do
      css = ContextMenu::Style.to_s

      css.should contain("anchor-name: --context-menu;")
      css.should contain("position-anchor: --context-menu;")
      css.should contain("position-area: block-end span-inline-start;")
      css.should contain("position-try-fallbacks: flip-block, flip-inline;")
      css.should contain("position: absolute;")
    end
  end

  describe ContextMenuController do
    it "keeps ARIA, focus, outside click, and Escape behavior in sync" do
      javascript = ContextMenuController.to_js

      javascript.should contain(%(setAttribute("aria-expanded", open)))
      javascript.should contain("this.menuTarget.focus();")
      javascript.should contain("if (this.element.contains(event.target) == false)")
      javascript.should contain("event.key == \"Escape\"")
      javascript.should contain("this.triggerTarget.focus();")
    end
  end
end
