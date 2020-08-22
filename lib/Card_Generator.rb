require './lib/card.rb'


class Card_Generator

attr_reader :cards
  def initialize
    @cards = []
  end

  def cards

    rank = [2,3,4,5,6,7,8,9,10,11,12,13,14]
    name = ['2','3','4','5','6','7','8','9','10','Jack','Queen','King','Ace']
    suit = [:heart, :diamond, :spade, :club]

    suit.each do |x|
      rank.each_with_index do |y, z|
        temp = Card.new(x, name[z], y)
        @cards << temp
      end
    end
    @cards
  end
end
