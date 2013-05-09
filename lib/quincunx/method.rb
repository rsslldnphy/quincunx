module Quincunx
  class Method

    def initialize(matchers, body)
      @matchers = matchers
      @body     = body
    end

    def call(*args)
      body.call(*args)
    end

    def ===(args)
      matchers.zip(args).all? { |(a,b)| a == b }
    end

    private

    attr_reader :matchers, :body

  end
end
