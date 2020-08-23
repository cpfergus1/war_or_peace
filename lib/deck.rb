require './lib/Card.rb'

class Deck
  attr_reader :cards
  def initialize(cards)
    @cards = cards
  end

  def rank_of_card_at(position)
    cards[position].rank
  end

  def high_ranking_cards
    highcards = []
    cards.each do |card|
      if card.rank >= 10
        highcards << card
      end
    end
    highcards
  end

  def percent_high_ranking
    count = 0
    cards.each do |card|
      if card.rank >= 11
        count += 1
      end
    end
    (count.to_f/cards.count().to_f)*100
  end

  def remove_card
    cards.delete_at(0)
  end

  def add_card(card)
    @cards += card
  end

end
