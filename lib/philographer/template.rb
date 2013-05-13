require_relative 'api_object'

module Philographer
  class Template
    include APIObject

    attribute :email_blurb
    attribute :email_subject
    attribute :documents
    attribute :recipients

    def initialize(attributes = {})
      super

      self.documents ||= []
      self.recipients ||= []
    end
  end
end
