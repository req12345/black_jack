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


    user_choice
  end

  def auto_bet
    @bank = BET * 2
    @player.bet
    @dealer.bet
  end

  def auto_deal
    2.times do
      player_get_card
      @dealer.get_card(@deck.draw_card)
    end
  end

  def player_get_card
    @player.get_card(@deck.draw_card)
  end

  def players_hand
    puts 'Your cards:'
    @player.hand do |c|
      puts "#{c.rank}#{c.suit.encode('utf-8')}"
    end
    puts "Total scores: #{@player.hand_scores}"
  end

  def dealer_hand
    puts 'DEALER cards:'
    @dealer.hand do |c|
      puts "#{c.rank}#{c.suit.encode('utf-8')}"
    end
    puts "Total scores: #{@dealer.hand_scores}"
  end

  def dealer_hand_hidden
    puts "\nDealer cards:"
    @dealer.cards.size.times { puts '*' }
  end

  def skip
    auto_open_cards
    if @dealer.hand_scores >= 17
    else
       @dealer.hand_scores < 17 && @dealer.cards.size < 3
       @dealer.get_card(@deck.draw_card)
    end
  end

  def open_cards
    players_hand
    dealer_hand
    game_results

  end

  def game_results
    if "#{@dealer.hand_scores}" > "#{@player.hand_scores}"
      @dealer.bank += @bank
      @bank = 0
      print 'You lose'
    elsif "#{@dealer.hand_scores}" == "#{@player.hand_scores}"
      @dealer.bank += @bank / 2
      @player.bank += @bank / 2
      @bank = 0
      print 'Draw'
    else
      @player.bank += @bank
      @bank = 0
      print 'You are the winner'
    end
  end

  def auto_open_cards
    open_cards if @player.cards.size == 3 && @dealer.cards.size == 3
  end

  def table_view
    players_hand
    dealer_hand_hidden
  end

  def user_choice
    table_view
    loop do
      auto_open_cards

      puts "\n1. Skip\n2. Add card\n3. Open cards"
      choice = gets.chomp.to_i

      case choice
      when 1 then skip
      when 2 then player_get_card
      when 3 then open_cards
      end
    end
  end



end

Game.new.start_game
