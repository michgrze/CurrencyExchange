class ExchangeRatesController < ApplicationController

  def index
    @current_date = Time.new.strftime("%Y-%m-%d")
    @alior_rates = ExchangeRate.alior_all
    @walutomat_rates = ExchangeRate.walutomat_all
  end
end
