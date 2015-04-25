class ExchangeRate

  attr_reader :code, :sell, :buy

  def self.alior_all
    Parsers::Alior.new.fetch
  end

  def self.walutomat_all
    Parsers::Walutomat.new.fetch
  end

  def self.cinkciarz_all
    Parsers::Cinkciarz.new.fetch
  end

  def initialize(options = {})
    @code = options[:code]
    @sell = options[:sell]
    @buy  = options[:buy]
  end

end
