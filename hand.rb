class Hand
  attr_accessor :scores, :cards, :total_scores

  def initialize
    @cards = []
  end

  def clear_hand
    @cards.clear
  end

  def get_card(card)
    @cards << card
  end

  def scores
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

  def cards(&block)
    @cards.each(&block)
  end
end
