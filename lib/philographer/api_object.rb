module Philographer
  module APIObject
    DEFAULT_ATTRIBUTE_OPTIONS = {
      type: String,
      required: false
    }.with_indifferent_access

    def self.included(base)
      base.send(:extend, ClassMethods)
    end

    def initialize(attributes = {})
      set_attributes(attributes)
    end

    private

    def set_attributes(attrs = {})
      attrs.each do |attr, value|
        if self.class.attribute_names.include?(attr.to_s)
          send("#{attr}=", value)
        end
      end
    end

    module ClassMethods
      def attribute(attr_name, options = {})
        opts = options.with_indifferent_access
        attributes[attr_name] = DEFAULT_ATTRIBUTE_OPTIONS.merge(options)
        attr_accessor attr_name
      end

      def attributes
        @attributes ||= HashWithIndifferentAccess.new
      end

      def attribute_names
        attributes.keys
      end
    end
  end
end
