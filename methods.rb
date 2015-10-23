
def begin_game

  # INITIALIZE
  puts "How many players will there be?"
  num_players = gets.chomp.to_i
  @players = []
  @loser = nil

  # CREATE PLAYERS
  num_players.times do |num|
    @player = {
    name: "",
    health: 3,
    score: 0
    }
    puts "What is the name of player #{num+1}?"
    @player[:name] = gets.chomp
    @players << @player
  end

  play_game
  
end

def play_round(player)
  num_1 = rand(20)
  num_2 = rand(20)
  ans = num_1 + num_2
  puts "#{player[:name]} is up! Here's your question:"
  puts "What is #{num_1} + #{num_2}?"
  answer = gets.chomp.to_i
  if answer == ans then
    player[:score] += 1 
    puts "RIGHT!"
    puts ""
  else
    player[:health] -= 1
    puts "WRONG! current score is"
    puts ""
    @players.each {|plyr| puts "#{plyr[:name]}: #{plyr[:health]}"}
    puts ""
  end
end

def play_game
  while !@loser do
    @players.each do |player|
      play_round(player) if !@loser
      if player[:health] == 0 then
        @loser = player[:name]
        puts "Game over! #{player[:name]} loses pitifully."
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