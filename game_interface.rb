require_relative 'card'
require_relative 'deck'
require_relative 'player'
require_relative 'dealer'
require 'byebug'

class Game
  BET = 10

  def initialize
    @bank = 0
    @deck = []
    @dealer = Dealer.new('Dealer')
    puts 'Enter your name'
    @player = Player.new(gets.chomp)
  end

  def interface #добавить цикл старт_гейм. еще?
    start_game
    if @player.bank == 0 || @dealer.bank == 0
      return print 'One of you is no money'
    else
      print "\nPlay again? (Y / any button for N)"
      choice = gets.chomp.capitalize!
      if choice == "Y"
        start_game
      else
        return
      end
    end
  end

  def start_game
    @deck = Deck.new
    @dealer.cards.clear
    @player.cards.clear
    auto_deal
    auto_bet
    menu
    open_cards
    game_results
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
    puts "\nYour cards:"
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
    if @dealer.hand_scores >= 17
      return
    elsif
      @dealer.hand_scores < 17 && @dealer.cards.size = 3
      return
    else
      @dealer.get_card(@deck.draw_card)
    end
    menu
  end

  def open_cards
    players_hand
    dealer_hand
    game_results
  end

  def game_results
    if @dealer.hand_scores > @player.hand_scores && @dealer.hand_scores <= 21
      @dealer.bank += @bank
      @bank = 0
      print 'You lose'
    elsif @dealer.hand_scores == @player.hand_scores
      @dealer.bank = @bank / 2
      @player.bank = @bank / 2
      @bank = 0
      print 'Draw'
    elsif
      @player.hand_scores <= 21
      @player.bank += @bank
      @bank = 0
      print 'You are the winner'
    end
  end

  def auto_open_cards
    open_cards
    game_results
  end

  def table_view
    players_hand
    dealer_hand_hidden
  end

  def menu
    loop do
      return auto_open_cards if @player.cards.size == 3 && @dealer.cards.size == 3
      table_view
      puts "\n1. Skip\n2. Add card\n3. Open cards"
      choice = gets.chomp.to_i

      case choice
      when 1 then skip
      when 2 then player_get_card
      when 3 then return open_cards
      end
    end
  end
end

Game.new.interface
