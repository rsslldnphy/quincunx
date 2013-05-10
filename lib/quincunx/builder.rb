module Quincunx

  class Builder

    def initialize(args, matchers)
      @args = args
      @matchers = matchers
    end

    def params
      args.zip(extractors).reduce({}) do |acc, (v, extractor)|
        acc.merge(Extractor.new(extractor, v).extract)
      end
    end

    private

    def extractors
      matchers.map { |m| m[1] || {} }
    end

    attr_reader :args, :matchers

  end
end
