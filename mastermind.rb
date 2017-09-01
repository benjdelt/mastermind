require_relative "colors.rb"
require_relative "board.rb"

class Mastermind
  include Board 
  @@turn = 1 
  @@feedback = [0,0,0]
  def initialize 
    @attempts = [["\u25af", "\u25af", "\u25af", "\u25af"], ["\u25af", "\u25af", "\u25af", "\u25af"], ["\u25af", "\u25af", "\u25af", "\u25af"], ["\u25af", "\u25af", "\u25af", "\u25af"], ["\u25af", "\u25af", "\u25af", "\u25af"], ["\u25af", "\u25af", "\u25af", "\u25af"], ["\u25af", "\u25af", "\u25af", "\u25af"], ["\u25af", "\u25af", "\u25af", "\u25af"], ["\u25af", "\u25af", "\u25af", "\u25af"], ["\u25af", "\u25af", "\u25af", "\u25af"], ["\u25af", "\u25af", "\u25af", "\u25af"], ["\u25af", "\u25af", "\u25af", "\u25af"]]
    @feedbacks = [["\u25E6", "\u25E6", "\u25E6", "\u25E6",], ["\u25E6", "\u25E6", "\u25E6", "\u25E6",], ["\u25E6", "\u25E6", "\u25E6", "\u25E6",], ["\u25E6", "\u25E6", "\u25E6", "\u25E6",], ["\u25E6", "\u25E6", "\u25E6", "\u25E6",], ["\u25E6", "\u25E6", "\u25E6", "\u25E6",], ["\u25E6", "\u25E6", "\u25E6", "\u25E6",], ["\u25E6", "\u25E6", "\u25E6", "\u25E6",], ["\u25E6", "\u25E6", "\u25E6", "\u25E6",], ["\u25E6", "\u25E6", "\u25E6", "\u25E6",], ["\u25E6", "\u25E6", "\u25E6", "\u25E6",], ["\u25E6", "\u25E6", "\u25E6", "\u25E6",], ]
    @hidden_code = ["\u25af", "\u25af", "\u25af", "\u25af"]
  end
  def menu 
    puts "MASTERMIND".red
    puts "\n"
    puts "Rules.".yellow 
    puts "The codemaker chooses a pattern of four code pegs."
    puts "The codebreaker tries to guess the pattern, in both order and color, within twelve turns. Each guess is made by placing a row of code pegs on the decoding board, picking one color peg at a time. Once placed, the computer provides feedback by placing from zero to four key pegs in the small holes of the row with the guess. A red key peg is placed for each code peg from the guess which is correct in both color and position. A white key peg indicates the existence of a correct color code peg placed in the wrong position."
    
    puts "\n\n Menu:".yellow
    puts "\n #{"1.".cyan} Play as codemaker"
    puts "\n #{"2.".cyan} Play as codebreaker"
    puts "\n\n"
    input = gets.chomp.to_i 
    until input == 1 || input == 2 
      puts "Please choose an option by typing \"1\" or \"2\""
      input = gets.chomp.to_i 
    end 
    input == 1 ? @player = CodeMaker.new : @player = CodeBreaker.new 
    @player 
  end
  def get_input
    input_to_color = {"R" => :red, "G" => :green, "Y" => :yellow, "B" => :blue, "M" => :magenta, "C" => :cyan}
    input = gets.chomp.to_s.upcase.split('')
    input = "x" if input == []
    input = input[0].to_s 
    until "RGYBMC".include? input 
      puts "You have to type the first letter of the color you want: (R)ed, (G)reen, (Y)ellow, (B)lue, (M)agenta and (C)yan."
      input = gets.chomp.to_s.upcase.split('')
      input = "x" if input == []
      input = input[0]
    end 
    puts "You picked #{input_to_color[input]}."
    input_to_color[input]
  end 
  def play
    menu 
    @player.set_code
    puts "Turn #{@@turn} begins."
    @player.codebreaker_attempt
    check_code
    update_attempts(@player.attempt, @attempts, @@turn)
    update_feedbacks(@@feedback, @feedbacks, @@turn)
    draw_board(@attempts, @feedbacks, @hidden_code)
    until end_game? 
      @@turn += 1
      puts "Turn #{@@turn} begins."
      @player.codebreaker_attempt
      check_code
      update_attempts(@player.attempt, @attempts, @@turn)
      update_feedbacks(@@feedback, @feedbacks, @@turn)
      draw_board(@attempts, @feedbacks, @hidden_code)
    end 
  end 
  
  private
  
  def check_code
    @@feedback = [0,0,0]
    @player.code.each_with_index {|s, i| @@feedback[0] += 1 if s == @player.attempt[i]}
    (@player.code - @player.attempt).size > (@player.attempt - @player.code).size ? @@feedback[2] = (@player.code - @player.attempt).size : @@feedback[2] = (@player.attempt - @player.code).size 
    @@feedback[1] = 4 - @@feedback[2] - @@feedback[0]
    puts "The codebreaker has #{@@feedback[0]} #{@@feedback[0] > 1 ? "pegs" : "peg"} of the right color at the right position, #{@@feedback[1]} #{@@feedback[1] > 1 ? "pegs" : "peg"} of the right color at the wrong position and #{@@feedback[2]} #{@@feedback[2] > 1 ? "pegs" : "peg"} of the wrong color."
    @@feedback
  end
  def end_game?
    if @@feedback[0] == 4 
      @hidden_code = reveal_code(@player.code, @hidden_code)
      puts "The game ends."
      draw_board(@attempts, @feedbacks, @hidden_code)
      puts "The codebreaker wins!"
      end_game = true 
    elsif @@turn >= 12 
      @hidden_code = reveal_code(@player.code, @hidden_code)
      puts "The game ends."
      draw_board(@attempts, @feedbacks, @hidden_code)
      puts "The codemaker wins!"
      end_game = true
    else
      end_game = false
    end
    end_game
  end
end 
class CodeBreaker < Mastermind
  attr_reader :attempt, :code
  def initialize 
    @code_pegs = [:red, :green, :yellow, :blue, :magenta, :cyan]
    @code = []
  end
  def set_code
    4.times do 
      @code << @code_pegs[rand(0..5)]
    end 
    puts "The computer has picked it's code."
    @code 
  end
  def codebreaker_attempt
    @attempt = [] 
    position = 1
    until @attempt.size == 4
      puts "Pick a color for position #{position.to_s} between (R)ed, (G)reen, (Y)ellow, (B)lue, (M)agenta and (C)yan."
      @attempt << get_input
      position += 1 
    end 
    @attempt
  end 
end 

class CodeMaker < Mastermind
  attr_reader :attempt, :code
  def initialize 
    @code_pegs = [:red, :green, :yellow, :blue, :magenta, :cyan].shuffle
    @code = []
    @combinations = @code_pegs.repeated_permutation(4).to_a
  end
  def set_code
    position = 1
    until @code.size == 4
      puts "Pick a color for position #{position.to_s} between (R)ed, (G)reen, (Y)ellow, (B)lue, (M)agenta and (C)yan."
      @code << get_input
      position += 1 
    end 
    puts "You picked #{@code[0]}, #{@code[1]}, #{@code[2]} and #{@code[3]}."
    @code
  end
  def codebreaker_attempt
    previous_attempt = @attempt
    @attempt = []
    new_combinations = []
    if @@turn == 1 
      @attempt = [@code_pegs[0], @code_pegs[0], @code_pegs[1], @code_pegs[1]]
    else 
      @combinations.map do |c|
        if check_code_computer(previous_attempt, c) == @@feedback
          new_combinations << c
        end 
      end 
      @attempt = new_combinations[0]
      @combinations = new_combinations
    end
    puts "The computer tries #{@attempt[0]}, #{@attempt[1]}, #{@attempt[2]} and #{@attempt[3]}."
    @attempt
  end
  
  private
  
  def check_code_computer(attempt, combination)
    local_feedback = [0,0,0]
    attempt.each_with_index {|s, i| local_feedback[0] += 1 if s == combination[i]}
    (attempt - combination).size > (combination - attempt).size ? local_feedback[2] = (attempt - combination).size : local_feedback[2] = (combination - attempt).size 
    local_feedback[1] = 4 - local_feedback[2] - local_feedback[0]
    local_feedback
  end
end 

game = Mastermind.new 
game.play 