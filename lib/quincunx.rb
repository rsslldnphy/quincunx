require 'delegate'
require 'optional'
require_relative 'quincunx/all'

module Quincunx

  def define name, *args, &body
    cases = dictionary.add(name, args, body)
    define_method name do |*args|
      cases.match(args).call
    end
  end

  private

  def dictionary
    @dictionary ||= Dictionary.new
  end

end
