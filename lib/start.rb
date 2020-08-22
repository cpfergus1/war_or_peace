Dir["./lib/*.rb"].each {|file| require file}

class Start

  def initialize()
    @prompt = '>'
    @begin = ''
  end

  def welcome
    puts """
    Welcome to War! (or Peace) This game will be played with 52 cards.
    The players today are Megan and Aurora.
    Type 'GO' to start the game!
    ------------------------------------------------------------------
    """
    print @prompt
    while @begin != "GO"
      @begin = $stdin.gets.chomp
      if @begin == 'GO' || @begin == "Go" || @begin == 'go'
        initiate
        break
      else
        puts 'I bet you meant GO, Type "GO" to start'
        puts ''
        print @prompt
      end
    end
  end

  def initiate
    #require 'pry' ; binding.pry
    generate = Card_Generator.new
    cards = generate.cards
    cards = cards.shuffle
    split1,split2 = cards.each_slice((cards.size/2).round).to_a
    deck1 = Deck.new(split1)
    deck2 = Deck.new(split2)
    player1 = Player.new('Megan',deck1)
    player2 = Player.new('Aurora', deck2)
    i=1
    while i <= 1000001
      if i > 1000000
        p '---- DRAW ----'
        break
      elsif player1.has_lost? || (player1.deck.rank_of_card_at(0) == player2.deck.rank_of_card_at(0) && player1.deck.cards.size < 3)
        p "*~*~*~* #{player2.name} has won the game! *~*~*~*"
        break
      elsif player2.has_lost? || (player1.deck.rank_of_card_at(0) == player2.deck.rank_of_card_at(0) && player2.deck.cards.size < 3)
        p "*~*~*~* #{player1.name} has won the game! *~*~*~*"
        break
      end
      player1.deck.cards.shuffle!
      player2.deck.cards.shuffle!
      turn = Turn.new(player1,player2)
      turnwinner = turn.winner
      case turn.type
      when :mutually_assured_destruction
        turn.pile_of_cards
        p "Turn #{i}: *mutually assured destruction* 6 cards removed from play"
        turn.award_spoils(turnwinner)
        print "#{player1.name} has #{player1.deck.cards.length} cards"
        print "  #{player2.name} has #{player2.deck.cards.length} cards"
        p ""
      when :war
        turn.pile_of_cards
        p "Turn #{i}: WAR - #{turnwinner.name} won #{turn.spoils_of_war.size}"
        turn.award_spoils(turnwinner)
        print "#{player1.name} has #{player1.deck.cards.length} cards"
        print "  #{player2.name} has #{player2.deck.cards.length} cards"
        p ""
      when :basic
        turn.pile_of_cards
        p "Turn #{i}: #{turnwinner.name} won #{turn.spoils_of_war.size}"
        turn.award_spoils(turnwinner)
        print "#{player1.name} has #{player1.deck.cards.length} cards"
        print "  #{player2.name} has #{player2.deck.cards.length} cards"
        p ""
      end
      i += 1
    end
  end
end
