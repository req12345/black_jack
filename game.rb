require_relative 'card'
require_relative 'deck'
require_relative 'bank'
require_relative 'player'
require_relative 'hand'
require_relative 'interface'

class Game
  def initialize
    @bank = Bank.new
    @deck = []
    @dealer = Player.new('Dealer')
    add_player
    @interface = Interface.new
    start_game
  end

  private

  def add_player
    print 'Enter your name'
    @player = Player.new(gets.chomp)
  end

  def start_game
    loop do
      preparadness

      table_interface

      @interface.player_turn(@player, @deck)
      @interface.dealer_turn(@dealer, @deck) unless @game_over

      @interface.players_hand(@player)
      @interface.dealer_hand(@dealer)
      @interface.game_results(@dealer, @player, @bank)

      if @interface.no_money(@player, @dealer)
        print Interface::NO_MONEY
        break
      end

      print "\n1. Play again \n0. Exit"
      choice = gets.chomp.to_i

      case choice
      when 1 then print "Let's play"
      when 0 then break
      end
    end
    @interface.game_over
  end

  def preparadness
    @game_over = false

    @interface.clear_hands(@dealer, @player)

    @deck = Deck.new

    @interface.start_bet(@dealer, @player, @bank)
    @interface.auto_deal(@dealer, @player, @deck)
  end

  def table_interface
    @interface.info(@dealer, @player)

    @interface.players_hand(@player)
    @interface.dealer_hand_hidden(@dealer)
  end
end

Game.new
