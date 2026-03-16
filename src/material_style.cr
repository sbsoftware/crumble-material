module Crumble::Material
  LAYER_NAME = :crumble_material
end

# Reuse the css.cr layer abstraction so every shard stylesheet shares the
# same layer name while preserving the existing asset and layout wiring.
macro material_style(name = Style, &blk)
  class {{name.id}} < CSS::LayerStylesheet
    def self.layer_name : String?
      CSS::LayerStylesheet.format_layer_name(Crumble::Material::LAYER_NAME)
    end

    {{blk.body}}
  end

  class ::ToHtml::Layout
    {% if @type == @top_level %}
      append_to_head ::{{name.id}}
    {% else %}
      append_to_head ::{{@type.name(generic_args: false)}}::{{name.id}}
    {% end %}
  end
end
