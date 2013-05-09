require 'spec_helper'

describe Quincunx do

  let (:test_class) {
    Class.new do
      extend Quincunx
      define :the_defined_method, :foo do
        :bar
      end
    end
  }

  subject { test_class.new }

  describe "#define" do
    it { should respond_to :the_defined_method }
    it "should return the thing from the dictionary" do
      subject.the_defined_method(:foo).should eq :bar
    end
  end

end
