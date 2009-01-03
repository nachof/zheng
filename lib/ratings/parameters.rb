module Zheng
  module Parameters
    module_function
    # These values are taken from the European Go Rating. See http://gemma.ujf.cas.cz/~cieply/GO/gor.html
    E = 0.014
    def A rating
      return 70 if rating >= 2700
      return rating * (-1.0/20) + (205)
    end
    def Con rating
      return 10 if rating > 2700
      return 116 if rating < 100
      parts = [ { :from => 100, :to => 200, :p => -6.0/100, :d => 122 },
                { :from => 200, :to => 1300, :p => -5.0/100, :d => 120 },
                { :from => 1300, :to => 2000, :p => -4.0/100, :d => 107 },
                { :from => 2000, :to => 2400, :p => -3.0/100, :d => 87 },
                { :from => 2400, :to => 2600, :p => -2.0/100, :d => 63 },
                { :from => 2600, :to => 2700, :p => -1.0/100, :d => 37 } ]
      parts.each do |f|
        return f[:p] * rating + f[:d] if rating >= f[:from] && rating <= f[:to]
      end
    end

    def expected ratingA, ratingB
      return (1 - E) - expected(ratingB, ratingA) if ratingA > ratingB
      return 1.0 / (Math::E ** ((ratingB - ratingA) / A(ratingA)) + 1)
    end
  end
end
