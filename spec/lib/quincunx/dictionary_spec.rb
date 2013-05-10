require 'spec_helper'

module Quincunx
  describe Dictionary do

    let (:dictionary) { Dictionary.new }

    it 'adds methods to the dictionary' do
      dictionary[:foo] << Method.new(:bar, :baz)
      dictionary[:foo].should be_a CaseList
    end

    it 'defaults case lists to empty' do
      dictionary[:quux].should be_a CaseList
    end
  end
end
