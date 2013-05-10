require 'spec_helper'

module Quincunx
  describe Method do

    let (:method) { Method.new([:cat, :dog], ->{ :bar }) }

    it 'can be called' do
      method.call.should eq :bar
    end

    it 'can be compared to an array of args' do
      method.should === [:cat, :dog]
    end

    it 'should not match a different array' do
      method.should_not === [:cat, :cat]
    end
  end
end
