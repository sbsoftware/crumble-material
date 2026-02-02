module Crumble
  module Material
    class WrapperAttrs
      @callbacks : Array(Proc(String, ToHtml::AttributeHash, Nil))

      def initialize(@callbacks : Array(Proc(String, ToHtml::AttributeHash, Nil)))
      end

      def to_html_attrs(tag, attrs)
        @callbacks.each do |callback|
          callback.call(tag, attrs)
        end
      end

      def self.none
        @@none ||= new([] of Proc(String, ToHtml::AttributeHash, Nil))
      end

      def self.from(wrapper_attrs : WrapperAttrs)
        wrapper_attrs
      end

      def self.from(wrapper_attrs : Nil)
        none
      end

      def self.from(wrapper_attrs : Array)
        callbacks = [] of Proc(String, ToHtml::AttributeHash, Nil)
        wrapper_attrs.each do |item|
          callbacks << build_callback(item)
        end
        new(callbacks)
      end

      def self.from(wrapper_attrs : Tuple)
        callbacks = [] of Proc(String, ToHtml::AttributeHash, Nil)
        wrapper_attrs.each do |item|
          callbacks << build_callback(item)
        end
        new(callbacks)
      end

      def self.from(wrapper_attrs)
        new([build_callback(wrapper_attrs)])
      end

      private def self.build_callback(item : T) forall T
        ->(tag : String, attrs : ToHtml::AttributeHash) do
          item.to_html_attrs(tag, attrs)
          nil
        end
      end
    end
  end
end
