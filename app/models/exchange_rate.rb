class ExchangeRate

  attr_reader :currency_code, :sell, :buy

  def initialize(options = {})
    @code = options[:code]
    @sell = options[:sell]
    @buy  = options[:buy]
  end

end
