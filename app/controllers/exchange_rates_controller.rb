class ExchangeRatesController < ApplicationController

  def index
    require 'open-uri'
    @current_date = Time.new.strftime("%Y-%m-%d")
    @CURRENCY_NAMES = %w{EUR USD CHF GBP}

    idx = 0

    @currency_names = @CURRENCY_NAMES

    open("http://kantor.aliorbank.pl/forex") do |f|
      @buy_all = {}
      @sell_all = {}
      f.each_line do |line|
        if idx < 4
          if line =~ /.*data-amount.*/

            currency = @CURRENCY_NAMES[idx]
            
            a = line.index('data-amount')
            buy = line[a + 13, 6]
            sell = line[a + 39, 6]

            @buy_all[currency] = buy
            @sell_all[currency] = sell

            idx += 1

          end
        end
      end
      puts "\n"
    end

  end
end
