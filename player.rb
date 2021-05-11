class Player
  attr_accessor :cards

  def initialize(name)
    @name = name
    @bank = 100
    @cards = []
  end

  def get_card(card)
   @cards.size < 3 ? @cards << card : 'Already 3 cards'
  end

  def bet
    @bank -= 10
  end

  def hand(&block)
    @cards.each(&block)
  end

end
