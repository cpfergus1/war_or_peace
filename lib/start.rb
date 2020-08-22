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
        break
      else
        puts 'I bet you meant GO, Type "GO" to start'
        puts ''
        print @prompt
      end
    initiate
    end
  end

  def initiate
    cards = 

  end


end
