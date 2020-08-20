require 'minitest/autorun'
require 'minitest/pride'
require './lib/card.rb'
require './lib/deck.rb'
require './lib/player.rb'
require './lib/turn.rb'

class TestTurn <Minitest::Test

  attr_accessor :deck1, :deck2
  attr_reader :turn, :player1, :player2

  def setup
    @card1 = Card.new(:heart, 'Jack', 11)
    @card2 = Card.new(:heart, '10', 10)
    @card3 = Card.new(:heart, '9', 9)
    @card4 = Card.new(:diamond, 'Jack', 11)
    @card5 = Card.new(:heart, '8', 8)
    @card6 = Card.new(:diamond, 'Queen', 12)
    @card7 = Card.new(:spade, '3', 3)
    @card8 = Card.new(:diamond, '2', 2)
    @deck1 = Deck.new([@card1, @card2, @card5, @card8])
    @deck2 = Deck.new([@card3, @card4, @card7, @card8])
    @player1 = Player.new("Megan", deck1)
    @player2 = Player.new("Aurora", deck2)
    @turn = Turn.new(player1, player2)
  end

  def test_turn_exists
    assert_instance_of Turn, turn
  end

  def test_turn_has_players
    assert_equal player1, turn.player1
    assert_equal player2, turn.player2
  end

end
