require 'open-uri'
require 'json'

module Parsers
  class Walutomat

    CURRENCY_NAMES = %w{EUR USD GBP CHF}
    URL = "https://panel.walutomat.pl/api/v1/best_offers.php"

    def fetch

      rates = []
      walutomat_hash = JSON.parse(open(URL).read)
      @idx = 0
      walutomat_hash['offers'].each do |currency_data|
        parsed = process_hash currency_data
        rates << parsed
        @idx +=1
      end

      change_rates_array_elements rates
      rates
    end

    private

    def process_hash(currency_data)

      rate = nil
      code, buy, sell = 0
      currency_data.each do |key, value|
        code = CURRENCY_NAMES[@idx] if key == "pair"
        buy = value if key == "sell"
        sell = value if key == "buy"
      end

      rate = ExchangeRate.new(code: code, sell: sell, buy: buy)

    end

    def change_rates_array_elements(array)
      change1 = array[2]
      change2 = array[3]
      array[2] = change2
      array[3] = change1

    end

  end

end
