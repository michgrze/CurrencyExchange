module ExchangeRateHelper

  def to_float(rates)
    rates.each do |rate|
      rate.buy.sub!(',', '.').to_f.round(4)
      rate.sell.sub!(',', '.').to_f.round(4)
    end
  end



end