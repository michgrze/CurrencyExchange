module Parsers

  class Alior

    CURRENCY_NAMES = %w{EUR USD CHF GBP}
    URL = 'http://kantor.aliorbank.pl/forex'

    def fetch
      rates = {}

      idx = 0
      open(URL) do |f|
        f.each_line do |line|
          if idx < 4
            if line =~ /.*data-amount.*/

              code = CURRENCY_NAMES[idx]

              a = line.index('data-amount')
              buy = line[a + 13, 6]
              sell = line[a + 39, 6]

              rates[code] = ExchangeRate.new(code: code, sell: sell, buy: buy)

              idx += 1

            end
          end
        end
      end

      rates

    end

  end

end
