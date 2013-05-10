require 'spec_helper'

describe Quincunx do

  let (:test_class) {
    Class.new do
      extend Quincunx

      define :speak, :cat do
        :miaow
      end

      define :speak, :dog do
        :woof
      end

    end
  }

  subject { test_class.new }

  describe "#define" do
    it { should respond_to :speak }

    it "should return the thing from the dictionary" do
      subject.speak(:cat).should eq :miaow
      subject.speak(:dog).should eq :woof
    end

  end

end
