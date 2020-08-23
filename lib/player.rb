require './lib/card.rb'
require './lib/deck.rb'
require './lib/turn.rb'

class Player
  attr_reader :cards, :name, :deck
  def initialize(name, deck)
    @name = name
    @deck = deck
  end
  def has_lost?
    deck.cards == [] || deck.cards.nil?
  end
end
