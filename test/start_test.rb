require 'minitest/autorun'
require 'minitest/pride'
require './lib/card.rb'
require './lib/deck.rb'
require './lib/player.rb'
require './lib/turn.rb'
require './lib/start.rb'

class TestStart <Minitest::Test

  def setup
    @Begin = ""
    @start = Start.new()
  end

  def test_instance_of
    assert_instance_of Start, @start
  end

  def test_welcome
    assert_equal @start.initiate, @start.welcome
  end

  def test_initiate
    assert_equal '*~*~*~* Aurora has won the game! *~*~*~*' , @start.initiate
end
