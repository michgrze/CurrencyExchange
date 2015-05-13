class ExchangeRatesController < ApplicationController

  def index
    @currency_names = %w{EUR USD CHF GBP}
    @current_date = Time.new.strftime("%Y-%m-%d")
    @all_rates = ExchangeRate.all

  end


end
