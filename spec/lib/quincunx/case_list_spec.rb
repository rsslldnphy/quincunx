require 'spec_helper'

module Quincunx
  describe CaseList do

    let (:case_list) { CaseList.new }

    it 'allows methods to be shovelled in and retrieved' do
      method = Method.new([:foo], :bar)
      case_list << method
      case_list.match([:foo]).should eq Some[method]
    end

    it 'returns a none when asked for a match if there is no match' do
      method = Method.new([:foo], :bar)
      case_list << method
      case_list.match([:bar]).should be_none
    end

    it 'returns the correct method if there are multiple ones' do
      first  = Method.new([:foo], :bar)
      second = Method.new([:baz], :quux)
      case_list << first << second
      case_list.match([:foo]).should eq Some[first]
      case_list.match([:baz]).should eq Some[second]
    end
  end
end
