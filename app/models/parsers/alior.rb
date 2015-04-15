module Parsers

  class Alior

    CURRENCY_NAMES = %w{EUR USD CHF GBP}
    URL = 'http://kantor.aliorbank.pl/forex'

    def fetch

      @idx = 0

      rates = []

      open(URL) do |f|
        f.each_line do |line|
          parsed = process_line line
          rates << parsed if parsed
        end
      end

      rates

    end

    private

    def process_line(line)

      rate = nil

      if @idx < 4

        if line =~ /.*data-amount.*/

          code = CURRENCY_NAMES[@idx]
          @idx += 1

          a = line.index('data-amount')
          buy = line[a + 13, 6]
          sell = line[a + 39, 6]

          rate = ExchangeRate.new(code: code, sell: sell, buy: buy)

        end
      end

      rate

    end

  end

end
