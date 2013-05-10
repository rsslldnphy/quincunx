require 'spec_helper'

module Quincunx
  describe Extractor do

    let (:cat) { Cat.new("Russell", "Tabby") }

    let (:extractor) { Extractor.new(matcher, cat) }

    subject { extractor.extract }

    context "given an array of keys" do
      let (:matcher) {{ keys: [:name, :type] }}

      it "extracts the keys specified in the matcher" do
        subject.should eq name: "Russell", type: "Tabby"
      end
    end

    context "given a hash of keys to names" do
      let (:matcher) {{ keys: { name: 'cat' } }}

      it "extracts the keys and adds them to hash using the specified name" do
        subject.should eq cat: "Russell"
      end
    end
  end
end
