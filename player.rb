class Player
  attr_accessor :cards, :bank, :hand, :cash
  attr_reader :total_scores, :name

  def initialize(name)
    @name = name
    @cash = 100
    @hand = Hand.new
  end

  def bet(money)
    @cash -= 10
  end

  def win(bank)
    @cash += bank
  end
end
