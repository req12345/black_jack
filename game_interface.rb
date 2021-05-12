require_relative 'card'
require_relative 'deck'
require_relative 'player'
require_relative 'dealer'
require 'byebug'

class Game
  BET = 10


  def initialize
    @bank = 0
    @deck = Deck.new
    @dealer = Dealer.new('Dealer')
    puts 'Enter your name'
    @player = Player.new(gets.chomp)
  end

  def start_game
    auto_deal
    auto_bet
    players_hand
    dealer_hand_hidden
    user_choice
  end

  def auto_bet
    @bank = BET * 2
    @player.bet
    @dealer.bet
  end

  def auto_deal
    2.times do
      @player.get_card(@deck.draw_card)
      @dealer.get_card(@deck.draw_card)
    end
  end

  def players_hand
    puts 'Your cards:'
    @player.hand do |c|
      puts "#{c.rank}#{c.suit.encode('utf-8')}"
    end
    puts "Total scores: #{@player.hand_scores}"
  end

  def dealer_hand_hidden
    puts "\nDealer cards:"
    @dealer.cards.size.times { puts '*' }
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

  def skip
    puts "#{@dealer.hand_scores}"
    if @dealer.hand_scores >= 17
      user_choice
    elsif
       @dealer.hand_scores < 17 && @dealer.cards.size < 3
       @dealer.get_card(@deck.draw_card)
    end
  end

end

Game.new.start_game
