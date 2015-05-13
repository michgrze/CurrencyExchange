
class ExchangeRate

  attr_reader :code, :sell, :buy
  attr_accessor :buy_flag, :sell_flag

  def self.all
    Parsers::All.new.fetch
  end

  def initialize(options = {})
    @code = options[:code]
    @sell = options[:sell]
    @buy  = options[:buy]
    @buy_flag = "regular"
    @sell_flag = "regular"
  end

end
