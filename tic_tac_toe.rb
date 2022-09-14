module Clear
  def clear
    print "\033[2J\033[H"
  end
end

class TicTacToe
  include Clear

  attr_accessor :positions, :winning_combos
  
  def initialize(p1, p2)
    @p1 = p1
    @p2 = p2
    @positions = [1, 2, 3, 4, 5, 6, 7, 8, 9]
    @winning_combos = [
      [1, 2, 3], 
      [4, 5, 6], 
      [7, 8, 9], 
      [1, 4, 7], 
      [2, 5, 8], 
      [3, 6, 9], 
      [1, 5, 9], 
      [3, 5, 7]
    ]
  end

  def draw_header
    puts "|=-=-=-=-=-=-=-=-=-=-=-=-=|"
    puts "|=-=-= TIC-TAC-TOE! -=-=-=|"
    puts "|=-=-=-=-=-=-=-=-=-=-=-=-=|"
    puts ""
  end

  def draw_board
    puts " #{@positions[0]} | #{@positions[1]} | #{@positions[2]}   |"
    puts "---+---+---  | #{@p1.player_symbol}: #{@p1.score}  (#{@p1.name})"
    puts " #{@positions[3]} | #{@positions[4]} | #{@positions[5]}   |"
    puts "---+---+---  | #{@p2.player_symbol}: #{@p2.score}  (#{@p2.name})"
    puts " #{@positions[6]} | #{@positions[7]} | #{@positions[8]}   |"
    puts ""
  end

  def update_board
    clear
    draw_header
    draw_board
  end
end

class Player
  include Clear

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
end

p1 = Player.new("X")
p2 = Player.new("O")
game = TicTacToe.new(p1, p2)
game.update_board