require_relative 'card'

class Deck
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
    'A' => 11,
  }

  SUITS = ["\u2660", "\u2663", "\u2665", "\u2666"]

  def initialize
    @deck = []
    generate_deck
    @deck.shuffle!
  end

  def generate_deck
    SUITS.each do |suit|
      RANK_SCORES.each do |rank, scores|
        @deck << Card.new(rank, suit.encode('utf-8'), scores)
      end
    end
  end

  def output_deck
    @deck.each do |card|
      card.output_card
    end
  end

  def draw_card
		@deck.shift
	end

	def shuffle!
		@deck.shuffle!
	end
end
