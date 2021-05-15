class Player
  attr_accessor :cards, :bank
  attr_reader :total_scores, :name

  def initialize(name)
    @name = name
    @bank = 100
    @cards = []
  end

  def get_card(card)
    @cards.size < 3 ? @cards << card : puts('Already 3 cards')
  end

  def bet
    @bank -= 10
  end

  def hand(&block)
    @cards.each(&block)
  end

  def hand_scores
    total_scores = 0
    without_aces = @cards.reject { |card| card.rank == 'A' }
    if @cards.size == without_aces.size
      total_scores = @cards.map(&:scores).sum.to_i
    else
      total_scores = without_aces.map(&:scores).sum.to_i
      aces = @cards - without_aces

      aces.each do |ace|
        scores = total_scores + ace.scores <= 21 ? ace.scores : 1
        total_scores += scores
      end
    end
    total_scores
  end
end
