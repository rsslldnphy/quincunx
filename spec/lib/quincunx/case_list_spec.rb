require 'spec_helper'

module Quincunx
  describe CaseList do

    let (:obj)       { stub }
    let (:case_list) { CaseList.new }

    it 'allows methods to be shovelled in and retrieved' do
      method = Method.new([[:foo]], ->{ :bar })
      case_list << method
      case_list.match(obj, [:foo]).map(&:call).should eq Some[:bar]
    end

    it 'returns a none when asked for a match if there is no match' do
      method = Method.new([[:foo]], ->{ :bar })
      case_list << method
      case_list.match(obj, [:bar]).map(&:call).should be_none
    end

    it 'returns the correct method if there are multiple ones' do
      first = Method.new([[:foo]], ->{ :bar })
      second = Method.new([[:baz]], ->{ :quux })
      case_list << first << second
      case_list.match(obj, [:foo]).map(&:call).should eq Some[:bar]
      case_list.match(obj, [:baz]).map(&:call).should eq Some[:quux]
    end
  end
end
