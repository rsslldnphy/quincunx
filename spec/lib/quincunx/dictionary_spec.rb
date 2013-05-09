require 'spec_helper'

module Quincunx
  describe Dictionary do

    let (:dictionary) { Dictionary.new }

    it 'defaults entries for methods as empty arrays' do
      dictionary[:foo].should eq []
    end

    it 'allows adding methods' do
      dictionary[:foo] << :bar
      dictionary[:foo] << :baz
      dictionary[:foo].should eq [:bar, :baz]
    end
  end
end
