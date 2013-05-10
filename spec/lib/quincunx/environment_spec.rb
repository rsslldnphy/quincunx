require 'spec_helper'

module Quincunx
  describe Environment do

    Cat = Struct.new(:name, :type)

    let (:cat)       { Cat.new("Russell", "Tabby") }
    let (:params)      {{ name: "Felix", paws: 3 }}

    let (:delegator) { Environment.new(cat, params) }

    it 'should delegate methods to the original object' do
      delegator.type.should eq "Tabby"
    end

    it 'should prefer values in the params hash' do
      delegator.name.should eq "Felix"
    end

    it 'should return values from the params' do
      delegator.paws.should eq 3
    end

  end
end
