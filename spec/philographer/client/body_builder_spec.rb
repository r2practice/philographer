require 'spec_helper'

module Philographer
  class Client
    describe BodyBuilder do
      describe '.build_for(object)' do
        describe 'when the object is plainly serializable' do
          let(:role) { TemplateRole.new }
          let(:object) { Envelope.new({
            status: 'sent',
            template_roles: [role]
          }) }
          let(:body) { BodyBuilder.build_for(object) }

          it 'must return the json representation of the object' do
            body.must_match /"status":"sent"/
          end
        end

        describe 'when the object contains one or more files' do
          let(:document) {
            path = File.expand_path('../../../test_files/basic.pdf', __FILE__)
            Document.new({
              path: path,
              id: 1
            })
          }
          let(:object) {
            Envelope.new({
              documents: [document]
            })
          }

          let(:body) { BodyBuilder.build_for(object) }

          it 'must return an array' do
            body.must_be :is_a?, Array
          end

          it 'must return parts that all have a :conent key' do
            assert body.all?{ |part| part[:content] }, "Expected all parts of the body array to have a :content key"
          end
        end
      end
    end
  end
end
