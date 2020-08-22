require 'minitest/autorun'
require 'minitest/pride'
require './lib/card.rb'
require './lib/deck.rb'



class DeckTest <Minitest::Test

  def setup
    @card1 = Card.new(:diamond, 'Queen', 12)
    @card2 = Card.new(:spade, '3', 3)
    @card3 = Card.new(:heart, 'Ace', 14)
    @card4 = Card.new(:club, '5', 5)
    @cards = [@card1, @card2, @card3]
    @deck = Deck.new(@cards)
  end

  def Test_deck_exists
    assert_instance_of Deck, @deck
  end

  def test_rank_of_cards
    assert_equal 12, @deck.rank_of_card_at(0)
  end

  def test_high_rank_cards
    high_cards = [@card1,@card3]
    assert_equal high_cards, @deck.high_ranking_cards
  end

  def test_percent_high_rank
    expected = @deck.percent_high_ranking
    assert_in_delta 66.67, expected, 0.01
  end

  def test_remove_card
    card_removed = [@card2, @card3]
    @deck.remove_card
    high_cards = [@card3]
    assert_equal card_removed, @deck.cards
  end

  def test_add_card
    card_added = [@card2, @card3, @card4]
    high_cards = [@card3]
    @deck.remove_card
    @deck.add_card([@card4])
    assert_equal card_added, @deck.cards
  end

end
