require 'delegate'
require 'optional'
require_relative 'quincunx/all'

module Quincunx
  Anything = Object
  def self.included(base)
    base.extend(PatternMatcher)
  end

  class NoMatchForPatternError < StandardError
  end

end
