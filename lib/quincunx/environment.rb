module Quincunx
  class Environment < SimpleDelegator

    def initialize(obj, params)
      super(obj)
      @params = params
    end

    def method_missing(name, *args, &block)
      params.fetch(name.to_sym) { super }
    end

    private

    attr_reader :params

    def self.factory(obj, args, matchers)
      new obj, Builder.new(args, matchers).params
    end

  end
end
