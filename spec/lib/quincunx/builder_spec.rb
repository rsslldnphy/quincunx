require 'spec_helper'

module Quincunx
  describe Builder do

    let (:russell)  { Cat.new("Russell", :tabby) }
    let (:griselda) { Cat.new("Griselda", :persian) }
    let (:args)     { [russell, griselda] }

    let (:matchers) {[
      [Cat, keys: [:type], as: :cat],
      [Cat, keys: [:name]]
    ]}

    let (:builder) { Builder.new(args, matchers) }

    it 'builds a hash of the passed params and extracted keys' do
      builder.params.should eq ({
        cat: russell,
        name: "Griselda",
        type: :tabby
      })
    end
  end
end
