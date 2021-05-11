class Card
  attr_reader :rank, :suit, :scores

  def initialize(rank, suit, scores)
    @rank = rank
    @suit = suit
    @scores = scores
  end
end
