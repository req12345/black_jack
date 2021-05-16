class Player
  attr_accessor :cards, :bank, :hand
  attr_reader :total_scores, :name

  def initialize(name)
    @name = name
    @bank = 100
    @hand = Hand.new
  end
end
