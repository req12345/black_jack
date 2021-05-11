require_relative 'card'
require_relative 'deck'
require_relative 'player'
# require_relative 'dealer'
require 'byebug'

class Game
  BET = 10

  def initialize
    @bank = 0
    @deck = Deck.new
    @dealer = Player.new('Dealer')
    puts 'Enter your name'
    @player = Player.new(gets.chomp)
  end

  def start_game
    deal_bet
    deal_cards
    players_hand
    puts "\nDealer cards:"
    dealer_hand_hidden
    user_choice
  end

  def deal_bet
    @bank = BET * 2
    @player.bet
    @dealer.bet
  end

  def deal_cards
    2.times do
      @player.get_card(@deck.draw_card)
      @dealer.get_card(@deck.draw_card)
    end
  end

  def players_hand
    total_scores = 0
    puts 'Your cards:'
    @player.hand do |c|
    puts "#{c.rank}#{c.suit.encode('utf-8')}"
    total_scores += c.scores
    end
    puts "Total scores: #{total_scores}"
  end

  def dealer_hand_hidden
    @dealer.cards.size.times {|c| puts '*'}
  end

  def user_choice
    puts "\n1. Skip\n2. Add card\n3. Open cards"
    choice = gets.chomp.to_i

    case when choice
    when 1 then skip
    when 2 then @player.get_card(@deck.draw_card)
    when 3 then open_cards
    end
  end
end

Game.new.start_game
