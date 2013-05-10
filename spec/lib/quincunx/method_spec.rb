require 'spec_helper'

module Quincunx
  describe Method do

    let (:method) { Method.new([[:cat], [:dog]], ->{ :bar }) }
    let (:env)    { stub }

    it 'can be compared to an array of args' do
      method.application(env, [:cat, :dog]).matches?
    end

    it 'should not match a different array' do
      method.application(env, [:cat, :cat])
    end
  end
end
