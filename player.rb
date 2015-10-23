class Player

  attr_accessor :name
  attr_accessor :health
  attr_reader :score

  def initialize(name)
    @name = name
    @score = 0
    @health = 3

  def right_answer
    @score += 1
    puts "RIGHT!".colorize(:light_green)
    puts 
  end

  def wrong_answer(correct_answer)
    @health -= 1
    puts "WRONG! The correct answer was #{correct_answer}".colorize(:red)
    puts 
  end
  end
end