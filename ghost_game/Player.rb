class Player
  attr_reader :name
  attr_accessor :loss_count

  def initialize(name)
    @name = name
    @loss_count = 0
  end

  def guess
    guess = gets.chomp

    while !self.valid_guess?(guess)
      puts "Invalid guess. Enter a single letter."
      guess = gets.chomp
    end
    
    return guess
  end

  def valid_guess?(char)
    if [*("a".."z"), *("A".."Z")].include?(char)
      return true
    else
      return false
    end
  end

  def eliminated?
    @loss_count == 5
  end


end