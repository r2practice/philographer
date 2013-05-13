module Philographer
  module APIObject
    DEFAULT_ATTRIBUTE_OPTIONS = {
      type: String,
      required: false
    }.with_indifferent_access

    def self.included(base)
      base.send(:extend, ClassMethods)
      base.class_eval do
        attribute :id
      end
    end

    def initialize(attributes = {})
      set_attributes(attributes)
    end

    def attributes=(attrs)
      set_attributes(attrs)
    end

    def attribute_names
      self.class.attribute_names
    end

    def json_id_key
      self.class.json_id_key
    end

    def save
      self.attributes = Philographer.client.post(self)
    end

    TYPED_OBJECTS = %w{recipients tabs}
    def as_json(options = {})
      attribute_names.inject({}) { |json, attr_name|
        if send(attr_name).present? && attr_name != 'type'
          value = send(attr_name)
          if TYPED_OBJECTS.include? attr_name
            json[attr_name] = build_typed_json_array(value)
          else
            name = json_key_for(attr_name)
            json[name] = value.is_a?(String) ? value : value.as_json
          end
        end
        json
      }
    end

    private

    def build_typed_json_array(typed_objects)
      typed_objects.inject({}) { |json, typed|
        json[typed.json_type] ||= []
        json[typed.json_type] << typed.as_json
        json
      }
    end

    def set_attributes(attrs = {})
      attrs.each do |attr, value|
        underscored_name = attr.to_s.underscore
        if json_id_key == attr.to_s
          self.id = value
        elsif attribute_names.include?(underscored_name)
          send("#{underscored_name}=", value)
        end
      end
    end

    def json_key_for(attr_name)
      attr_name == 'id' ? json_id_key : attr_name.camelize(:lower)
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

      def json_id_key
        return @json_id_key if @json_id_key
        lowercase_name = name.demodulize.downcase
        @json_id_key = "#{lowercase_name}Id"
      end
    end
  end
end
