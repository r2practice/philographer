require 'spec_helper'

module Philographer
  describe APIObject do
    let(:klass) { Class.new do
      include APIObject

      attribute :something
      attribute :another_thing
    end }
    let(:object) { klass.new }
  end
end
