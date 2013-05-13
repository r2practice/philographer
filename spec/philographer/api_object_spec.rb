require 'spec_helper'
require 'philographer/api_object'

module Philographer
  describe APIObject do
    let(:klass) { Class.new do
      include APIObject

      attribute :something
      attribute :another_thing
      attribute :tabs
      attribute :recipients
    end }
    let(:object) { Dummy.new }

    before do
      Philographer.const_set('Dummy', klass) unless defined? Dummy
    end

    describe 'inclusion into a class' do
      it 'must add an id attribute without user interaction' do
        klass.attribute_names.must_include 'id'
      end
    end

    describe '#initialize(attributes = {})' do
      let(:id) { SecureRandom.uuid }

      describe 'when underscored keys are passed' do
        let(:object) { Dummy.new({
          id: id,
          something: "A value",
          another_thing: "Some value"
        }) }

        it 'must set the id correctly' do
          object.id.must_equal id
        end

        it 'must set the underscored attribute(s) correctly' do
          object.another_thing.must_equal "Some value"
        end
      end

      describe 'when camelcased keys are passed' do
        let(:object) { Dummy.new({
          "dummyId" => id,
          'something' => "A value",
          'anotherThing' => "Another value"
        }) }

        it 'must set the id correctly' do
          object.id.must_equal id
        end

        it 'must set the underscored attributes correctly' do
          object.another_thing.must_equal "Another value"
        end
      end
    end

    describe '#save' do
      let(:mock_client) { MiniTest::Mock.new }
      let(:id) { SecureRandom.uuid }

      before do
        @original_client = Philographer.client
        Philographer.client = mock_client
        mock_client.expect :post, {'dummyId' => id}, [object]
      end

      after do
        Philographer.client = @original_client
      end

      describe "when the id hasn't been set" do
        before do
          object.save
        end

        it "must set the objects id" do
          object.id.must_equal id
        end

        it "must call into the client to do the http interaction" do
          mock_client.verify
        end
      end
    end

    describe '#as_json' do
      let(:id) { SecureRandom.uuid }
      let(:mock_object) {
        klass = Class.new do
          def as_json(options = {})
            "REGEX_THIS"
          end
        end

        klass.new
      }

      let(:object) {
        Dummy.new({
          id: id,
          another_thing: "Blah",
          something: mock_object,
          tabs: [Tab.new({type: 'sign_here', x_position: '100'})],
          recipients: [Recipient.new(type: 'signer', name: 'John Smith', email: "john@smith.com")]
        })
      }

      let(:json) { object.as_json }

      it "must send the id with the classname" do
        json.keys.must_include 'dummyId'
        json['dummyId'].must_equal id
      end

      it 'must change underscored attribute names to camelcased keys' do
        json.keys.must_include 'anotherThing'
        json['anotherThing'].must_equal "Blah"
      end

      it 'must call to_json on non-string elements' do
        json.keys.must_include 'something'
        json['something'].must_equal 'REGEX_THIS'
      end

      it 'must build tab arrays in their goofy typed way' do
        json['tabs'].must_equal({
          'signHereTabs' => [
            {
              'xPosition' => '100'
            }
          ]
        })
      end

      it 'must build the recipients array in the goofy typed way' do
        json['recipients'].must_equal({
          'signers' => [
            {
              'name' => 'John Smith',
              'email' => 'john@smith.com'
            }
          ]
        })
      end
    end
  end
end
