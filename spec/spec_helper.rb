require 'simplecov'
SimpleCov.start do
  add_filter '/spec'
end

require 'rspec'
require 'quincunx'

RSpec.configure do |config|
  config.order = :rand
  config.color_enabled = true
end

class Cat
  def initialize(name, type)
    @name = name
    @type = type
  end

  attr_reader :name, :type
end

class Person
  def initialize(name, age)
    @name = name
    @age = age
  end

  attr_reader :name, :age
end
