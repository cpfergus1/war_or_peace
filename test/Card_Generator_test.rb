require 'minitest/autorun'
require 'minitest/pride'
require './lib/Card_Generator.rb'

class TestCard_Generator <Minitest::Test

  def setup
    @generate = Card_Generator.new("./lib/cards.txt")
    @card = []
  end

  def test_generator_exists
    assert_instance_of Card_Generator, @generate
  end

  def test_create_a_card
    @generate = Card_Generator.new("./test/cards_test.txt").cards
    card0= @generate[0]
    rank = card0.rank
    suit = card0.suit
    name = card0.value
    assert_equal 12, rank
    assert_equal :club, suit
    assert_equal "Queen", name
  end

  def test_vaidate_cards
    card = ["Jack", :heart, 11]
    assert_equal false, @generate.validate_card(card)

    card = ["Freddy Mercury", :ear_drum_slayer, 999]
    assert_equal true, @generate.validate_card(card)
  end

  def test_create_deck
    assert_equal 52 , @generate.cards.length
  end
end
