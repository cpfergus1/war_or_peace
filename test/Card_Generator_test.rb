require 'minitest/autorun'
require 'minitest/pride'
require './lib/Card_Generator.rb'

class TestCard_Generator <Minitest::Test

  def setup
    @generate = Card_Generator.new()
  end

  def test_generator_exists
    assert_instance_of Card_Generator, @generate
  end

  def test_create_cards
    assert_equal 52 , @generate.cards.length
  end
end
