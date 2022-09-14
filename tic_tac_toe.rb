class Board
  def draw_header
    puts "|=-=-=-=-=-=-=-=-=-=-=-=-=|"
    puts "|=-=-=- TIC-TAC-TOE -=-=-=|"
    puts "|=-=-=-=-=-=-=-=-=-=-=-=-=|"
    puts ""
  end

  def draw_board
    
  end

end

class Player
  attr_accessor :name, :player_symbol, :score
  
  def initialize (player_symbol)
    get_player_name(player_symbol)
    @player_symbol = player_symbol
    @score = 0
  end

  def draw_header
    clear
    puts "|=-=- It's Time to... -=-=|"
    puts "|=-= D-D-D-D-D-D-D-D- -=-=|"
    puts "|=-=-=-= -DUEL! -=-=-=-=-=|"
    puts ""
  end

  def get_player_name(player_symbol)
    draw_header
    puts "#{player_symbol} player, what is your name?"
    @name = gets.chomp
  end

  def clear
    print "\033[2J\033[H"
  end
end

p1 = Player.new("X")
p2 = Player.new("O")