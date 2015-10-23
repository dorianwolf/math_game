def begin_game

  # INITIALIZE
  puts "Great! How many players will there be?"
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
        ask_to_play(true)
      end
    end
  end
end

def ask_to_play(again = false)
  puts "would you like to play?"
  answer = gets.chomp.to_s.downcase
  case answer
  when /\s*yes\s*/
    begin_game unless again
    if again then
      puts "Same players?"
        again = gets.chomp == 'yes'
        if again then
          puts "great!"
          reset_players
          play_game
        else
          puts again
        end
    end
  when /\s*no\s*/
    puts "fine.."
  else 
    puts "huh?"
    ask_to_play(again)
  end

end

def highest_scorer
  winner = @players[0]
  @players.each do |player|
    winner = player if player.score > winner.score
  end
  if tied(winner.score) then
    "When there's a tie, nobody" 
  else
    winner.name
  end
end

def reset_players
  puts
  @players.each do |player|
    player.health = 3
    @loser = nil
  end
end

def tied(score)
  counter = 0
  @players.each do |player|
    counter += 1 if player.score == score
  end
  counter >= 2
end