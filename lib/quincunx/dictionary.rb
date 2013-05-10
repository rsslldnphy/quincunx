module Quincunx
  class Dictionary

    def [](name)
      methods[name] ||= CaseList.new
      methods[name]
    end

    def methods
      @methods ||= {}
    end

  end
end
