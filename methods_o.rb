def begin_game

  # INITIALIZE
  puts "How many players will there be?"
  num_players = gets.chomp.to_i
  @players = []
  @loser = nil

  # CREATE PLAYERS
  num_players.times do |num|
    puts "What is the name of player #{num+1}?"
    name = gets.chomp
    @players << Player.new(name)
  end
  puts "Great!"
  puts

  play_game
  
end

def play_round(player)
  num_1 = rand(20)
  num_2 = rand(20)
  operator = ['+', '-' ,'*'].sample[0]
  ans = eval("num_1#{operator}num_2")
  puts "#{player.name.colorize(:light_magenta)} is up! Here's your question:"
  puts "What is #{num_1} #{operator} #{num_2}?".colorize(:cyan)
  answer = gets.chomp.to_i
  if answer == ans then
    player.right_answer
  else
    player.wrong_answer(ans)
    puts "Current score is:"
    @players.each {|plyr| puts "#{plyr.name}: #{plyr.score}"}
    puts 
  end
end

def play_game
  while !@loser do
    @players.each do |player|
      play_round(player) if !@loser
      if player.health == 0 then
        @loser = player.name
        puts "Game over! #{highest_scorer.colorize(:light_magenta)} wins!"
        print "Once again, " 
        ask_to_play
      end
    end
  end
end

def ask_to_play
  puts "would you like to play?"
  answer = gets.chomp.to_s.downcase
  case answer
  when "yes"
    begin_game
  when "no"
    puts "fine.."
  else 
    puts "huh?"
    ask_to_play
  end

end

def highest_scorer
  highest_scorer = @players[0]
  # tie = false
  @players.each do |player|
    # tie = true if player.score == highest_scorer.score
    highest_scorer = player if player.score > highest_scorer.score
  end
  highest_scorer.name
  # "In a tie, everybody" if tie
end