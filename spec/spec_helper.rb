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

Cat = Struct.new(:name, :type)
