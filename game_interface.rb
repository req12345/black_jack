require_relative 'card'
require_relative 'deck'
require_relative 'player'

class Game
  def initialize
    @bank = 0
    @deck = []
    @dealer = Player.new('Dealer')
  end

  def interface
    puts 'Enter your name'
    @player = Player.new(gets.chomp)

    start_game
  end

  def start_game
    puts "Let's play"
    i = 0
    loop do
      i += 1
      @game_over = false
      @bank = 0

      @dealer.cards.clear
      @player.cards.clear

      @deck = Deck.new

      puts "\n-=-=-=-=-=-=-=-=-=-=-=-=-=-"
      puts "Round № #{i}"
      puts "#{@player.name} —  #{@player.bank}"
      puts "#{@dealer.name} —  #{@dealer.bank}"
      puts '-=-=-=-=-=-=-=-=-=-=-=-=-=-'

      auto_bet
      auto_deal

      players_hand
      dealer_hand_hidden

      player_turn
      dealer_turn unless @game_over

      open_cards
      return if @player.bank.zero? || @dealer.bank.zero?

      print "\n1. Play again \n0. Exit"
      choice = gets.chomp.to_i

      case choice
      when 1 then puts "Let's play"
      when 0 then break
      end
    end
    puts 'Game over'
  end

  def player_turn
    puts "\n1. Skip turn\n2. Add card\n3. Open cards"
    choice = gets.chomp.to_i

    case choice
    when 1 then nil
    when 2 then @player.get_card(@deck.draw_card)
    when 3 then @game_over = true
    end
  end

  def dealer_turn
    @dealer.get_card(@deck.draw_card) if @dealer.hand_scores < 17 && @dealer.cards.size < 3
  end

  def auto_bet
    @bank = 20
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
    puts "\nYour cards:"
    @player.hand do |c|
      puts "#{c.rank}#{c.suit.encode('utf-8')}"
    end
    puts "Total scores: #{@player.hand_scores}"
  end

  def dealer_hand
    puts "\nDEALER cards:"
    @dealer.hand do |c|
      puts "#{c.rank}#{c.suit.encode('utf-8')}"
    end
    puts "Total scores: #{@dealer.hand_scores}"
  end

  def dealer_hand_hidden
    puts "\nDealer cards:"
    @dealer.cards.size.times { puts '*' }
  end

  def open_cards
    players_hand
    dealer_hand
    puts "\nxXxXxXxXxXxXxXxXxX"
    game_results
    puts "\nxXxXxXxXxXxXxXxXxX"
  end

  def game_results
    if @dealer.hand_scores > @player.hand_scores && (@dealer.hand_scores <= 21)
      @dealer.bank += @bank
      print '     You LOSE'
    elsif @dealer.hand_scores == @player.hand_scores && @dealer.hand_scores <= 21
      @dealer.bank += @bank / 2
      @player.bank += @bank / 2
      print '       DRAW'
    else
      @player.hand_scores <= 21
      @player.bank += @bank

      print 'You are the WINNER'
    end
  end
end

Game.new.interface
