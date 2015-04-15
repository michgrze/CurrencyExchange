class ExchangeRatesController < ApplicationController

  def index

    @current_date = Time.new.strftime("%Y-%m-%d")
    @currency_names = ExchangeRates::CURRENCY_NAMES
    @rates = ExchangeRates.new.fetch

  end
end
