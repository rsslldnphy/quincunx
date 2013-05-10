module Quincunx
  class CaseList

    def << method
      cases << method ; self
    end

    def match(args)
      Option[cases.find { |method| method === args }]
    end

    private

    def cases
      @cases ||= []
    end

  end

end
