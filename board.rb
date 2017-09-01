module Board 
  
  def color_to_pegs(array)
    pegs = array.map do |s|
      case s 
        when :red
          "\u25ae".red 
        when :green 
          "\u25ae".green
        when :blue 
          "\u25ae".blue
        when :cyan
          "\u25ae".cyan
        when :magenta
          "\u25ae".magenta
        when :yellow
          "\u25ae".yellow
        end
    end 
    pegs
  end 
  def update_attempts(attempt, attempts, turn)
    attempts[turn-1] = color_to_pegs(attempt)
  end 
  def update_feedbacks(feedback, feedbacks, turn)
    feedbacks[turn-1] = []
    feedback[0].times {feedbacks[turn-1] << "\u2022".red}
    feedback[1].times {feedbacks[turn-1] << "\u2022"}
    feedback[2].times {feedbacks[turn-1] << "\u25E6"}
    feedbacks 
  end 
  def reveal_code(code, hidden_code)
    hidden_code = color_to_pegs(code)
  end 
  def draw_board(attempts, feedbacks, hidden_code)
    puts "\n"
    puts hidden_code.join(' ')
    puts "----------------"
    puts "----------------"
    puts "            #{feedbacks[11][0]} #{feedbacks[11][1]}"
    puts "            #{feedbacks[11][2]} #{feedbacks[11][3]}"
    puts attempts[11].join(' ')
    puts "----------------"
    puts "            #{feedbacks[10][0]} #{feedbacks[10][1]}"
    puts "            #{feedbacks[10][2]} #{feedbacks[10][3]}"
    puts attempts[10].join(' ') 
    puts "----------------"
    puts "            #{feedbacks[9][0]} #{feedbacks[9][1]}"
    puts "            #{feedbacks[9][2]} #{feedbacks[9][3]}"
    puts attempts[9].join(' ')
    puts "----------------"
    puts "            #{feedbacks[8][0]} #{feedbacks[8][1]}"
    puts "            #{feedbacks[8][2]} #{feedbacks[8][3]}"
    puts attempts[8].join(' ')
    puts "----------------"
    puts "            #{feedbacks[7][0]} #{feedbacks[7][1]}"
    puts "            #{feedbacks[7][2]} #{feedbacks[7][3]}"
    puts attempts[7].join(' ')
    puts "----------------"
    puts "            #{feedbacks[6][0]} #{feedbacks[6][1]}"
    puts "            #{feedbacks[6][2]} #{feedbacks[6][3]}"
    puts attempts[6].join(' ')
    puts "----------------"
    puts "            #{feedbacks[5][0]} #{feedbacks[5][1]}"
    puts "            #{feedbacks[5][2]} #{feedbacks[5][3]}"
    puts attempts[5].join(' ') 
    puts "----------------"
    puts "            #{feedbacks[4][0]} #{feedbacks[4][1]}"
    puts "            #{feedbacks[4][2]} #{feedbacks[4][3]}"
    puts attempts[4].join(' ')
    puts "----------------"
    puts "            #{feedbacks[3][0]} #{feedbacks[3][1]}"
    puts "            #{feedbacks[3][2]} #{feedbacks[3][3]}"
    puts attempts[3].join(' ')
    puts "----------------"
    puts "            #{feedbacks[2][0]} #{feedbacks[2][1]}"
    puts "            #{feedbacks[2][2]} #{feedbacks[2][3]}"
    puts attempts[2].join(' ')
    puts "----------------"
    puts "            #{feedbacks[1][0]} #{feedbacks[1][1]}"
    puts "            #{feedbacks[1][2]} #{feedbacks[1][3]}"
    puts attempts[1].join(' ')
    puts "----------------"
    puts "            #{feedbacks[0][0]} #{feedbacks[0][1]}"
    puts "            #{feedbacks[0][2]} #{feedbacks[0][3]}"
    puts attempts[0].join(' ')
    puts "\n"
    puts "\n"
  end 
end 
# update_attempts(attempt, attempts, turn)
# update_feedbacks(feedback, feedbacks, turn)
# draw_board(attempts, feedbacks, hidden_code)