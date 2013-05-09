module Quincunx
  class Dictionary

    def add(name, args, body)
      cases(name) << Method.new(args, body)
    end

    def cases(name)
      methods[name] ||= CaseList.new
      methods[name]
    end

    def methods
      @methods ||= {}
    end

    class CaseList

      def << method
        cases << method ; self
      end

      def match(args)
        cases.first { |method| method === args }
      end

      private

      def cases
        @cases ||= []
      end

    end

  end
end
