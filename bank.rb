class Bank
  BET = 10

  attr_reader :bank

  def initialize
    @bank = 0
  end

  def auto_bet(player, dealer)
    player.bet(BET)
    dealer.bet(BET)
    @bank = BET * 2
  end

  def winner(player)
    player.win(@bank)
    @bank = 0
  end

  def draw(player, dealer)
    player.win(@bank / 2)
    dealer.win(@bank / 2)
    @bank = 0
  end

# rubocop:disable all

  def no_money?(player, dealer)
    player.cash > BET
    dealer.cash > BET
  end
end
