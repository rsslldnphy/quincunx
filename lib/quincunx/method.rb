module Quincunx
  class Method

    def initialize(params, body)
      @params = params
      @body   = body
    end

    attr_reader :params, :body

    def application(obj, args)
      Application.new(obj, args, params, body)
    end

    private

    Application = Struct.new(:obj, :args, :params, :body) do

      def call
        env.instance_exec(&body)
      end

      def matches?
        correct_arg_count? && args_match? && contains_right_keys? && passes_guard?
      end

      def env
        @env ||= Environment.factory(obj, args, matchers)
      end

      def correct_arg_count?
        matchers.count == args.count
      end

      def args_match?
        pairs.all? { |(a,b)| a.first === b }
      end

      def contains_right_keys?
        pairs.all? do |(a,b)|
          (a[1] || {}).fetch(:keys, []).all? { |k| b.respond_to? k }
        end
      end

      def passes_guard?
        env.instance_exec(&guard)
      end

      def pairs
        matchers.zip(args)
      end

      def guard
        params.last.is_a?(Hash) ? params.last.fetch(:when) : ->{ true }
      end

      def matchers
        @matchers ||= params.take_while { |p| p.is_a? Array }
      end

    end
  end
end
