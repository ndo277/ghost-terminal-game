require "set"
require_relative "Player.rb"

class Game

  attr_reader :players

  def initialize(player_1, player_2, *other_players)
    @dictionary = Set.new []
    IO.foreach("dictionary.txt") {|line| @dictionary << line.chomp}

    @players = []
    players = [player_1, player_2, *other_players]
    players.each {|player| @players << Player.new(player) if player.is_a? String}

    @current_player = @players[0]
    @fragment = ""
    @turn = 0
  end

  def run 
    self.play_round
  end

  def over?
    @players.length == 1
  end

  def play_round 
    self.take_turn
    if self.lose?
      self.print_fragment
      puts "#{@current_player.name} spelled a word! Next round!"
      @current_player.loss_count += 1
      self.print_game_record
      self.eliminate_player
      @fragment = ""
      sleep(2)
    end
    self.next_player!
  end

  def eliminate_player
    if @current_player.eliminated?
      @players.delete(@current_player)
      puts "#{@current_player.name} is eliminated!"
      sleep(2)
    end
  end

  def print_game_record
    @players.each do |player| 
      puts "#{player.name}: #{to_letters(player.loss_count)}"
    end
  end

  def to_letters(count)
    case count
    when 1
      "G" 
    when 2
      "GH"
    when 3
      "GHO"
    when 4
      "GHOS"
    when 5
      "GHOST"
    end
  end

  def next_player!
    @turn += 1
    @current_player = @players[@turn % @players.length]
  end

  def print_fragment
    puts "Current fragment: #@fragment"
  end

  def lose?
    @dictionary.include?(@fragment)
  end

  def take_turn
    system("clear")
    self.print_fragment
    puts "#{@current_player.name}, enter a guess:"
    guess = @current_player.guess

    while !valid_play?(guess)
      puts "Invalid play. Try again."
      guess = @current_player.guess
    end

    if valid_play?(guess)
      @fragment += guess
    end

  end

  def valid_play?(str)
    str.downcase!
    @dictionary.any? {|word| word.start_with?(@fragment + str)}
  end



end

