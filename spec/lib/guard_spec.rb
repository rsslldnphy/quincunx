require 'spec_helper'

class Drink
end

class SoftDrink < Drink
end

class Alcopop < Drink
end

class Bar
  include Quincunx

  define :serve_irresponsibly, Person, Anything do
    "here you go!"
  end

  define :serve, [Person, keys: [:name]], SoftDrink do
    "A soft drink? No problem, #{name}"
  end

  define :serve, [Person, keys: [:name, :age]], Alcopop, when: ->{ age < 18 } do
    "No chance, #{name}, you're only #{age}!"
  end

  define :serve,
    [Person, keys: [:name, :age]],
    [Alcopop, as: :drink],
    when: -> { age >= 18 } do

    "Here you go, #{name}, here's your #{drink.class}"
  end
end

describe Bar do

  let (:bar)    { Bar.new }
  let (:child)  { Person.new("Russell", 17) }
  let (:adult)  { Person.new("Jeremy Irons", 44) }
  let (:hooch)  { Alcopop.new }
  let (:ribena) { SoftDrink.new }

  describe "#serve_irresponsibly" do
    it 'serves anyone anything' do
      bar.serve_irresponsibly(child, hooch).should eq "here you go!"
    end
  end

  describe "#serve" do
    it 'will serve anyone a soft drink' do
      bar.serve(child, ribena).should eq "A soft drink? No problem, Russell"
    end

    it 'will not serve children alcopops' do
      bar.serve(child, hooch).should eq "No chance, Russell, you're only 17!"
    end

    it 'will serve adults alcopops' do
      bar.serve(adult, hooch).should eq "Here you go, Jeremy Irons, here's your Alcopop"
    end
  end
end
