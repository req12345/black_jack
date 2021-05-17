class Card
  RANK_SCORES = {
    '2' => 2,
    '3' => 3,
    '4' => 4,
    '5' => 5,
    '6' => 6,
    '7' => 7,
    '8' => 8,
    '9' => 9,
    '10' => 10,
    'J' => 10,
    'Q' => 10,
    'K' => 10,
    'A' => 11
  }.freeze

  SUITS = ["\u2660", "\u2663", "\u2665", "\u2666"].freeze
  attr_reader :rank, :suit, :scores

  def initialize(rank, suit, scores)
    @rank = rank
    @suit = suit
    @scores = scores
  end
end
