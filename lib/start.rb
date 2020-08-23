Dir["./lib/*.rb"].each {|file| require file}

class Start

  def initialize()
    @prompt = '>'
    @begin = ''
    @player1 = ''
    @player2 = ''
    @turn_counter = 0

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
    game_setup
    loop do
      if check_for_winner_draw_or_shuffle == true
        break
      else
        take_turn
      end
      @turn_counter += 1
    end
  end

  def game_setup
    generate = Card_Generator.new("cards.txt")
    cards = generate.cards
    cards = cards.shuffle
    split1,split2 = cards.each_slice((cards.size/2).round).to_a
    deck1 = Deck.new(split1)
    deck2 = Deck.new(split2)
    @player1 = Player.new('Megan',deck1)
    @player2 = Player.new('Aurora', deck2)
    @turn_counter=1
  end

  def check_for_winner_draw_or_shuffle
    if @turn_counter > 1000000
      p '---- DRAW ----'
      true
    elsif @player1.has_lost?
      p "*~*~*~* #{@player2.name} has won the game! *~*~*~*"
      true
    elsif @player2.has_lost?
      p "*~*~*~* #{@player1.name} has won the game! *~*~*~*"
      true
    elsif @turn_counter%1000 == 0
      @player1.deck.cards.shuffle!
      @player2.deck.cards.shuffle!
      false
    else
      false
    end
  end

  def take_turn
    turn = Turn.new(@player1,@player2)
    if player_doesnt_have_enough_cards_to_play == true
      return
    end
    turnwinner = turn.winner
    case turn.type
    when :mutually_assured_destruction
      turn.pile_of_cards
      puts "Turn #{@turn_counter}: *mutually assured destruction* 6 cards removed from play"
      turn.award_spoils(turnwinner)
    when :war
      turn.pile_of_cards
      puts "Turn #{@turn_counter}: WAR - #{turnwinner.name} won #{turn.spoils_of_war.size}"
      turn.award_spoils(turnwinner)
    when :basic
      turn.pile_of_cards
      puts "Turn #{@turn_counter}: #{turnwinner.name} won #{turn.spoils_of_war.size}"
      turn.award_spoils(turnwinner)
    end
  end

  def player_doesnt_have_enough_cards_to_play
    if @player1.deck.cards[2].nil? && (@player1.deck.rank_of_card_at(0) == @player2.deck.rank_of_card_at(0))
      cards_remaining = @player1.deck.cards.length
      cards_remaining.times {@player1.deck.remove_card}
      return true
    elsif @player2.deck.cards[2].nil? && (@player1.deck.rank_of_card_at(0) == @player2.deck.rank_of_card_at(0))
      cards_remaining = @player2.deck.cards.length
      cards_remaining.times {@player2.deck.remove_card}
      return true
    else
      false
    end
  end
end
