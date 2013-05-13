require 'spec_helper'

module Philographer
  describe Document do
    let(:path) { File.expand_path('../../test_files/basic.pdf', __FILE__) }
    let(:document) {
      Document.new({
        path: path.to_s
      })
    }

    describe '#file' do
      it 'must return a file handle for the specified path' do
        file = document.file
        file.must_be :is_a?, File
        file.path.must_equal path
      end
    end

    describe '#name' do
      it "must extract the file's name from the path" do
        document.name.must_equal 'basic.pdf'
      end
    end
  end
end
