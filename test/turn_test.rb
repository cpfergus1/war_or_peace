require 'minitest/autorun'
require 'minitest/pride'
require './lib/card.rb'
require './lib/deck.rb'
require './lib/player.rb'
require './lib/turn.rb'

class TestTurn <Minitest::Test

  def setup
    @card1 = Card.new(:heart, 'Jack', 11)
    @card2 = Card.new(:heart, '10', 10)
    @card3 = Card.new(:heart, '9', 9)
    @card4 = Card.new(:diamond, 'Jack', 11)
    @card5 = Card.new(:spade, '8', 8)
    @card6 = Card.new(:diamond, 'Queen', 12)
    @card7 = Card.new(:spade, '3', 3)
    @card8 = Card.new(:diamond, '2', 2)
    @card9 = Card.new(:spade, 'Jack', 11)
    @card10 = Card.new(:club, '10', 10)
    @card11 = Card.new(:club, 'Jack', 11)
    @card12 = Card.new(:spade, 'king', 13)
    @card13 = Card.new(:heart, '8', 8)
    @card14 = Card.new(:club, 'Queen', 12)
    @card15 = Card.new(:diamond, '3', 3)
    @card16 = Card.new(:spade, '2', 2)
    @deck1 = Deck.new([@card1, @card2, @card5, @card8])
    @deck2 = Deck.new([@card3, @card4, @card6, @card7])
    @deckwar1 = Deck.new([@card9, @card10, @card13, @card16])
    @deckwar2 = Deck.new([@card11, @card12, @card14, @card15])
    @deckmut1 = Deck.new([@card9, @card10, @card13, @card16])
    @deckmut2 = Deck.new([@card11, @card12, @card5, @card15])
    @player1 = Player.new("Megan", @deck1)
    @player2 = Player.new("Aurora", @deck2)
    @playerwar1 = Player.new("Megan", @deckwar1)
    @playerwar2 = Player.new("Aurora", @deckwar2)
    @playermut1 = Player.new("Megan", @deckmut1)
    @playermut2 = Player.new("Aurora", @deckmut2)
    @turn = Turn.new(@player1, @player2)
    @turnwar = Turn.new(@playerwar1, @playerwar2)
    @turnmut = Turn.new(@playermut1, @playermut2)
  end

  def test_turn_exists
    assert_instance_of Turn, @turn
  end

  def test_turn_has_attributes
    assert_equal @player1, @turn.player1
    assert_equal @player2, @turn.player2
    assert_equal [], @turn.spoils_of_war
  end

  def test_turn_has_type
    assert_equal :basic, @turn.type
    assert_equal :war, @turnwar.type
    assert_equal :mutually_assured_destruction, @turnmut.type
  end

  def test_winner_of_turn
    assert_equal @player1, @turn.winner
    assert_equal @playerwar2, @turnwar.winner
  end

  def test_pile_of_cards
    @turn.pile_of_cards
    assert_equal [@card1, @card3], @turn.spoils_of_war
    assert_equal [@card2,@card5,@card8], @player1.deck.cards
    assert_equal [@card4,@card6,@card7], @player2.deck.cards

    @turnwar.pile_of_cards
    assert_equal [@card9, @card10, @card13, @card11, @card12, @card14], @turnwar.spoils_of_war
    assert_equal [@card16], @playerwar1.deck.cards
    assert_equal [@card15], @playerwar2.deck.cards

    @turnmut.pile_of_cards
    assert_equal [], @turnmut.spoils_of_war
    assert_equal [@card16], @playermut1.deck.cards
    assert_equal [@card15], @playermut2.deck.cards

  end

  def test_award_spoils
    winner = @turn.winner
    @turn.pile_of_cards
    @turn.award_spoils(winner)
    assert_equal [@card2, @card5, @card8, @card1, @card3], @player1.deck.cards
    assert_equal [@card4,@card6,@card7], @player2.deck.cards
  end

end
