require_relative "Player.rb"
require_relative "Game.rb"

puts "Enter players' names with a space inbetween each."
names = gets.chomp.split

while names.length < 2
  puts "Enter at least 2 players."
  names = gets.chomp.split
end

game = Game.new(*names)

game.run until game.over? 
puts "GAME OVER"
puts "#{game.players[0].name} wins!"

