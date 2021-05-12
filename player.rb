class Player
  attr_accessor :cards
  attr_reader :total_scores

  def initialize(name)
    @name = name
    @bank = 100
    @cards = []
  end

  def get_card(card)
   @cards.size < 3 ? @cards << card : 'Already 3 cards'
   hand_scores
  end

  def bet
    @bank -= 10
  end

  def hand(&block)
    @cards.each(&block)
  end

  def hand_scores
    total_scores = 0
    @cards.each { |card| total_scores += card.scores }
    total_scores
  end
end
