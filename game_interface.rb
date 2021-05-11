require_relative 'card'
require_relative 'deck'
require_relative 'player'
require 'byebug'

class Game
  BET = 10

  attr_reader :card, :scores
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
    @player.hand do |c|
    puts "#{c.rank} #{c.suit.encode('utf-8')}"
    total_scores += c.scores
    end
    puts "Total scores: #{total_scores}"
  end
end

Game.new.start_game
