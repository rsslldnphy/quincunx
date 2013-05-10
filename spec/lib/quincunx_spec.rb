require 'spec_helper'

Person = Struct.new(:name)

describe Quincunx do

  let (:test_class) {
    Class.new do
      extend Quincunx

      define :speak, [:cat] do
        :miaow
      end

      define :speak, [:dog] do
        :woof
      end

      define :speak, [Person] do
        :hello
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

    it "can match on class" do
      russell = Person.new("russell")
      subject.speak(russell).should eq :hello
    end

  end

end
