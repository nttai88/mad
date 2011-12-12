# encoding: utf-8
class Agreement
  class << self
    def entrepreneur
      return <<-str
System's Entrepreneur Agreement
      str
    end
    def advisor
      return <<-str
System's Advisor Agreement
      str
    end
    def partner
      return <<-str
System's Partner Agreement
      str
    end
  end
end
