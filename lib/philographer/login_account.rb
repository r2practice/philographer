module Philographer
  class LoginAccount
    def initialize(attributes)
      @attributes = attributes.with_indifferent_access
    end

    def id
      @id ||= @attributes['accountId']
    end

    def is_default
      @is_default ||= @attributes['isDefault'] == 'true'
    end
  end
end
