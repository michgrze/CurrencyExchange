require 'open-uri'

module Parsers
  class Cinkciarz

    CURRENCY_NAMES = %w{ EUR USD CHF GBP}
    URL = "https://cinkciarz.pl"
    TD_NUMBERS_WITH_SELL_RATES = [5,13,1,9]
    TD_NUMBERS_WITH_BUY_RATES = [6,14,2,10]

    def fetch
      idx = 0
      rates = []
      CURRENCY_NAMES.each do |currency_name|
        code = currency_name
        sell = create_sell_value(idx)
        buy = create_buy_value(idx)
        idx+=1
        rate = ExchangeRate.new(code: code, sell: sell, buy: buy)
        rates << rate
      end
      rates
    end

    private

    def create_buy_values
      @buy_values = []
      doc = Nokogiri::HTML(open(URL))

      TD_NUMBERS_WITH_BUY_RATES.each do |number|
        buy_value = doc.css("table.currencies td")[number].text
        @buy_values << buy_value
      end
    end

    def create_sell_values
      @sell_values = []
      doc = Nokogiri::HTML(open(URL))

      TD_NUMBERS_WITH_SELL_RATES.each do |number|
        sell_value = doc.css("table.currencies td")[number].text
        @sell_values << sell_value
      end
    end

    def create_buy_value(index)
      create_buy_values
      value = @buy_values[index]
    end

    def create_sell_value(index)
      create_sell_values
      value = @sell_values[index]
    end

  end
end




