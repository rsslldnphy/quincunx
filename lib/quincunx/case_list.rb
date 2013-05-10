module Quincunx
  class CaseList

    def << method
      cases << method ; self
    end

    def match(obj, args)
      Option[cases.map { |method| method.application(obj, args) }.find(&:matches?)]
    end

    private

    def cases
      @cases ||= []
    end

  end

end
