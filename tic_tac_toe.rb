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
    @p1_selections = []
    @p2 = p2
    @p2_selections = []
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
    @has_winner = false
    @p1_wins = false
    @p2_wins = false
    update_board
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

  
  def play_game
    p1_active = false
    p2_active = false

    until @has_winner
      until p2_active
        puts "#{@p1.name}, enter a number to place an #{@p1.player_symbol}:"
        selection = gets.chomp.to_i
      
        if (1..9).include?(selection) == false
          update_board
          next
        elsif @positions[selection - 1] == "X" || @positions[selection - 1] == "O"
          update_board
          next
        else 
          @p1_selections.push(@positions[selection - 1])
          @positions[selection - 1] = @p1.player_symbol
          update_board
          check_winner
          p1_active = false
          p2_active = true
        end
      end

      if @has_winner
        break
      end

      until p1_active
        puts "#{@p2.name}, enter a number to place an #{@p2.player_symbol}:"
        selection = gets.chomp.to_i
      
        if (1..9).include?(selection) == false
          update_board
          next
        elsif @positions[selection - 1] == "X" || @positions[selection - 1] == "O"
          update_board
          next
        else 
          @p2_selections.push(@positions[selection - 1])
          @positions[selection - 1] = @p2.player_symbol
          update_board
          check_winner
          p2_active = false
          p1_active = true
        end
      end
      next
    end

    if @has_winner
      if @p1_wins
        @p1.score += 1
        update_board
        puts "Congrats #{@p1.name}! You win!"
      elsif @p2_wins
        @p2.score += 1
        update_board
        puts "Congrats #{@p2.name}! You win!"
      else
        update_board
        puts "It's a draw!"
      end
    end

    puts "Would you like to go again? [Y/n]"
    
    selection = gets.chomp.downcase
  
    if selection == "y"
      @p1_selections = []
      @p2_selections = []
      @positions = [1, 2, 3, 4, 5, 6, 7, 8, 9]
      @has_winner = false
      @p1_wins = false
      @p2_wins = false
      update_board
      play_game
    else
      update_board
      puts "Come play again sometime, #{@p1.name} and #{@p2.name}!"
    end
  end

  def check_winner
    @winning_combos.each do |set|
      if (set & @p1_selections).sort == set.sort
        @has_winner = true
        @p1_wins = true
      end
      if (set & @p2_selections).sort == set.sort
        @has_winner = true
        @p2_wins = true
      end
    end

    if @positions.none? { |i| i.is_a?(Integer) }
      @has_winner = true
    end
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
game.play_game