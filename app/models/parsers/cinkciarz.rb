require 'open-uri'

module Parsers
  class Cinkciarz
    include ExchangeRateHelper

    CURRENCY_NAMES = %w{EUR USD CHF GBP}
    URL = "https://cinkciarz.pl"
    DOC = Nokogiri::HTML(open(URL))
    TD_NUMBERS_WITH_SELL_RATES = [5,13,1,9]
    TD_NUMBERS_WITH_BUY_RATES = [6,14,2,10]

    def fetch
      rates = []
      CURRENCY_NAMES.each_with_index do |currency_name, index|
        code = currency_name
        sell = create_sell_value(index)
        buy = create_buy_value(index)
        rate = ExchangeRate.new(code: code, sell: sell, buy: buy)
        rates << rate
      end
      to_float rates
    end

    private

    def create_buy_values
      buy_values = TD_NUMBERS_WITH_BUY_RATES.map {
        |number| get_value_from_td_number(number)
      }
    end

    def create_sell_values
      sell_values = TD_NUMBERS_WITH_SELL_RATES.map {
          |number| get_value_from_td_number(number)
      }
    end

    def get_value_from_td_number(number)
      value = DOC.css("table.currencies td")[number].text
    end

    def create_buy_value(index)
      create_buy_values[index]

    end

    def create_sell_value(index)
      create_sell_values[index]
    end

  end
end




