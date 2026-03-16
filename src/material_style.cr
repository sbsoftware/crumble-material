module Crumble::Material
  LAYER_NAME = "crumble-material"
end

# Wrap every shard stylesheet in the same cascade layer while preserving
# the existing per-component asset structure and automatic layout includes.
macro material_style(name = Style, &blk)
  class {{name.id}} < CSS::Stylesheet
    class LayerBody < CSS::Stylesheet
      {{blk.body}}
    end

    def self.to_s(io : IO)
      io << "@layer " << Crumble::Material::LAYER_NAME << " {\n"
      LayerBody.to_s(io)
      io << "\n}"
    end
  end

  class ::ToHtml::Layout
    {% if @type == @top_level %}
      append_to_head ::{{name.id}}
    {% else %}
      append_to_head ::{{@type.name(generic_args: false)}}::{{name.id}}
    {% end %}
  end
end
