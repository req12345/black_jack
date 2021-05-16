require_relative 'card'
require_relative 'deck'
require_relative 'player'
require_relative 'hand'
require_relative 'interface'

class Game
  def initialize
    @bank = 0
    @deck = []
    @dealer = Player.new('Dealer')
    add_player
    @interface = Interface.new
    start_game
  end

  private

  def add_player
    puts 'Enter your name'
    @player = Player.new(gets.chomp)
  end

  def start_game
    loop do
      @game_over = false
      @bank = 0

      @interface.clear_hands(@dealer, @player)

      @deck = Deck.new

      @interface.auto_bet(@dealer, @player, @bank)
      @interface.auto_deal(@dealer, @player, @deck)

      @interface.info(@dealer, @player)

      @interface.players_hand(@player)
      @interface.dealer_hand_hidden(@dealer)

      player_turn
      dealer_turn unless @game_over

      @interface.players_hand(@player)
      @interface.dealer_hand(@dealer)
      @interface.game_results(@dealer, @player, @bank)

      break if @player.bank.zero? || @dealer.bank.zero?

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
    when 2 then @player.hand.get_card(@deck.draw_card)
    when 3 then @game_over = true
    end
  end

  def dealer_turn
    @dealer.hand.get_card(@deck.draw_card) if @dealer.hand.scores < 17 && @dealer.hand.cards.size < 3
  end
end

Game.new
