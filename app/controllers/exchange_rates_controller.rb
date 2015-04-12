class ExchangeRatesController < ApplicationController

  def index
    @current_date = Time.new.strftime("%Y-%m-%d")
  end

end
