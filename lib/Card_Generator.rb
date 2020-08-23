require './lib/card.rb'



class Card_Generator

attr_reader :cards, :valid_cards
  def initialize(filename)
    @cards = []
    @valid_cards = []
    @filename = filename
  end


  def cards

    card_file = File.open(@filename)
    card_file_data = card_file.readlines.map(&:chomp)
    card_file.close
    card_file_data.each do |x|
      data = x.split(',')
      #require 'pry' ; binding.pry
      temp = [data[0].gsub(/\s+/,"").to_s.capitalize, data[1].gsub(/\s+/,"").downcase.to_sym, data[2].gsub(/\s+/,"").to_i]
      if validate_card(temp) == false
        card = Card.new(temp[1],temp[0],temp[2])
        @cards << card
      else
        puts "#{temp} is an invalid card"
      end
    end
    @cards
  end
  #   Previous itteration -
  #   rank = [2,3,4,5,6,7,8,9,10,11,12,13,14]
  #   name = ['2','3','4','5','6','7','8','9','10','Jack','Queen','King','Ace']
  #   suit = [:heart, :diamond, :spade, :club]
  #
  #   suit.each do |x|
  #     rank.each_with_index do |y, z|
  #       temp = Card.new(x, name[z], y)
  #
  #       @cards << temp
  #     end
  #   end
  #   @cards
  # end

  def validate_card(card)

    rank = [2,3,4,5,6,7,8,9,10,11,12,13,14]
    name = ['2','3','4','5','6','7','8','9','10','Jack','Queen','King','Ace']
    suit = [:heart, :diamond, :spade, :club]

    suit.each do |suit|
      rank.each_with_index do |rank, nam|
        temp = [name[nam], suit, rank]
        @valid_cards << temp
      end
    end
    #require 'pry' ; binding.pry
    @valid_cards.index(card).nil?
  end
end
