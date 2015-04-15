require 'open-uri'

class ExchangeRates

  CURRENCY_NAMES = %w{EUR USD CHF GBP}

  def fetch

    idx = 0

    rates = {}

    open('http://kantor.aliorbank.pl/forex') do |f|
      f.each_line do |line|
        if idx < 4
          if line =~ /.*data-amount.*/

            currency = CURRENCY_NAMES[idx]

            a = line.index('data-amount')
            buy = line[a + 13, 6]
            sell = line[a + 39, 6]

            rates[currency] = { sell: sell, buy: buy }

            idx += 1

          end
        end
      end
      puts "\n"
    end

    rates

  end

end
