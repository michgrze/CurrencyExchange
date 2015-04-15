require 'open-uri'

class ExchangeRates


  def self.all
    Parsers::Alior.new.fetch
  end

end
