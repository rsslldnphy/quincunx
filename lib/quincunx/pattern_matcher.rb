module Quincunx

  module PatternMatcher

    def define name, *args, &body
      cases = dictionary[name] << Method.new(args, body)
      define_method name do |*args, &block|
        cases.match(self, args).match do |m|
          m.some { |body| body.call }
          m.none { raise NoMatchForPatternError }
        end
      end
    end

    private

    def dictionary
      @dictionary ||= Dictionary.new
    end

  end
end
