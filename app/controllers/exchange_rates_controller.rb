class ExchangeRatesController < ApplicationController

  def index

    @currency_names = %w{EUR USD CHF GBP}
    @current_date = Time.new.strftime("%Y-%m-%d")
    @all_rates = ExchangeRate.all

    respond_to do |format|

      format.html
      format.json do
        result = { result: @all_rates }
        render json: result
      end

    end

  end


end
