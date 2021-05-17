class Interface
  attr_accessor :player, :bank, :deck, :round_number, :choice

  BET = 10
  NO_MONEY = "\nSomeone run out of money".freeze
  GAME_OVER = "\nGame over".freeze

  def initialize
    @round_number = 0
  end

  def game_over
    puts "\nGame over"
  end

  def clear_hands(dealer, player)
    dealer.hand.clear_hand
    player.hand.clear_hand
  end

  def info(dealer, player)
    puts "\n-=-=-=-=-=-=-=-=-=-=-=-=-=-"
    puts "Round № #{@round_number}"
    puts "#{player.name} —  #{player.cash}"
    puts "#{dealer.name} —  #{dealer.cash}"
    puts '-=-=-=-=-=-=-=-=-=-=-=-=-=-'
    @round_number += 1
  end

  def player_bet(player)
    player.bank -= BET
  end

  def start_bet(dealer, player, bank)
    bank.auto_bet(player, dealer)
  end

  def auto_deal(dealer, player, deck)
    2.times do
      player.hand.get_card(deck.draw_card)
      dealer.hand.get_card(deck.draw_card)
    end
  end

  def players_hand(player)
    puts "\nYour cards:"
    player.hand.cards do |c|
      puts "#{c.rank}#{c.suit.encode('utf-8')}"
    end
    puts "Total scores: #{player.hand.scores}"
  end

  def dealer_hand(dealer)
    puts "\nDEALER cards:"
    dealer.hand.cards do |c|
      puts "#{c.rank}#{c.suit.encode('utf-8')}"
    end
    puts "Total scores: #{dealer.hand.scores}"
  end

  def dealer_hand_hidden(dealer)
    puts "\nDealer cards:"
    dealer.hand.cards.size.times { puts '*' }
  end

  def player_turn(player, deck)
    puts "\n1. Skip turn\n2. Add card\n3. Open cards"
    choice = gets.chomp.to_i

    case choice
    when 1 then nil
    when 2 then player.hand.get_card(deck.draw_card)
    when 3 then @game_over = true
    end
  end

  def dealer_turn(dealer, deck)
    dealer.hand.get_card(deck.draw_card) if dealer.hand.scores < 17 && dealer.hand.cards.size < 3
  end

  def no_money(player, dealer)
    player.cash.zero? || dealer.cash.zero?
  end

# rubocop:disable all

  def game_results(dealer, player, bank)
    puts "\nxXxXxXxXxXxXxXxXxX"
    if (dealer.hand.scores > player.hand.scores) && (dealer.hand.scores <= 21)
      bank.winner(dealer)
      print '     You LOSE'
    elsif (dealer.hand.scores <= 21) && (player.hand.scores > 21)
      bank.winner(dealer)
      print '     You LOSE'
    elsif player.hand.scores > 21 && dealer.hand.scores > 21
      print '    Lose BOTH'
    elsif dealer.hand.scores == player.hand.scores && dealer.hand.scores <= 21
      bank.draw(player, dealer)
      print '       DRAW'
    elsif player.hand.scores <= 21
      bank.winner(player)
      print 'You are the WINNER'
    end
    puts "\nxXxXxXxXxXxXxXxXxX"
  end
end
