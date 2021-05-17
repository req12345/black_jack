class Deck
  def initialize
    @deck = []
    generate_deck
    @deck.shuffle!
  end

  def generate_deck
    Card::SUITS.each do |suit|
      Card::RANK_SCORES.each do |rank, scores|
        @deck << Card.new(rank, suit.encode('utf-8'), scores)
      end
    end
  end

  def draw_card
    @deck.shift
  end
end
