class ExchangeRatesController < ApplicationController

  def index
    require 'open-uri'
    @current_date = Time.new.strftime("%Y-%m-%d")
    @CURRENCY_NAMES = ["EUR", "USD", "CHF", "GBP"]

    open("http://kantor.aliorbank.pl/forex") do |f|
      counter = 0
      @i = 0
      @buy_all = []
      @sell_all = []
      f.each_line do |line|
        if counter < 4
          if line =~ /.*data-amount.*/
            counter +=1
            a = line.index('data-amount')
            #puts "\n"
            #puts line[a - 5, 3]
            buy = line[a + 13, 6]
            @buy_all << buy
            sell = line[a + 39, 6]
            @sell_all << sell
            #puts "Buy: #{buy}"
            #puts "Sell: #{sell}" +"\n"
          end
        end
      end
      puts "\n"
    end

  end
end
