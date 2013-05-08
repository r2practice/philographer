module Philographer
  class Tab
    include APIObject

    attribute :document_id
    attribute :page_number
    attribute :type
    attribute :x_position
    attribute :y_position

  end
end
