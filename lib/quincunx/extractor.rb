module Quincunx

  class Extractor

    def initialize(matcher, value)
      @matcher = matcher
      @value = value
    end

    def extract
      as ? values.merge(as.to_sym => value) : values
    end

    def values
      case
        keys
      when Array
        keys.reduce({}) { |acc, k| acc.merge(k => value.send(k)) }
      when Hash
        keys.reduce({}) { |acc, (k, v)| acc.merge(v.to_sym => value.send(k)) }
      end
    end

    private

    def keys
      matcher.fetch(:keys, [])
    end

    def as
      matcher.fetch(:as, false)
    end

    attr_reader :matcher, :value

  end
end

