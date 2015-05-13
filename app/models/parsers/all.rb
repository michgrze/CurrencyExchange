module Parsers
  class All

    def fetch
      change_flags(Parsers::Alior.new.fetch + Parsers::Walutomat.new.fetch + Parsers::Cinkciarz.new.fetch)
    end

    def change_flags(all_rates)

      change_currency_flags(all_rates, "EUR")
      change_currency_flags(all_rates, "USD")
      change_currency_flags(all_rates, "CHF")
      change_currency_flags(all_rates, "GBP")

    end

    def change_currency_flags (all_rates, currency)
      all_currency = all_rates.select {|x| x.code == currency}

      all_buy = []
      all_sell =[]

      all_currency.each do |currency|
        all_buy << currency.buy
        all_sell << currency.sell
      end

      index_min = all_buy.each_with_index.min[1]
      index_max = all_sell.each_with_index.max[1]

      all_currency[index_min].buy_flag = "bargain"
      all_currency[index_max].sell_flag = "bargain"

      all_rates

    end

  end

end