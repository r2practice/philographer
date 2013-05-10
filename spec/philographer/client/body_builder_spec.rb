require 'spec_helper'

module Philographer
  class Client
    describe BodyBuilder do
      describe '.build_for(object)' do
        describe 'when the object is plainly serializable' do
          it 'is not implemented yet' do
            skip "Basic Forms aren't implemented yet"
          end
        end

        describe 'when the object contains one or more files' do
          let(:document) {
            path = File.expand_path('../../../test_files/basic.pdf', __FILE__)
            Document.new(path)
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
