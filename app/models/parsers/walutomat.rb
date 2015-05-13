require 'open-uri'
require 'json'

module Parsers
  class Walutomat
    include ExchangeRateHelper

    CURRENCY_NAMES = %w{EUR USD GBP CHF}
    URL = "https://panel.walutomat.pl/api/v1/best_offers.php"

    def fetch

      rates = []
      walutomat_hash = JSON.parse(open(URL).read)
      @idx = 0
      walutomat_hash['offers'].each do |currency_data|
        rates << process_hash(currency_data)
        @idx +=1
      end

      to_float(rates.insert(2, rates.delete_at(3)))
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

  end

end
