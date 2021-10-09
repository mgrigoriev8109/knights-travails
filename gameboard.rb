require_relative "knight"
require_relative "node"

class GameBoard

  attr_accessor :gameboard

  def initialize(gameboard = [])
    @gameboard = gameboard
  end

  def create_gameboard
    @gameboard = [Array.new(8, "x"){Array.new(8, "x")}]
  end

  def update_gameboard(array)
    array.each do |node_on_path|
      p node_on_path
      @gameboard[node_on_path] = 'k'
    end
  end

  def display_gameboard
    @gameboard.each do |row|
     p row
    end
  end

end
first_knight = Knight.new
new_gameboard = GameBoard.new
new_gameboard.create_gameboard
new_gameboard.gameboard[7,7] = 's' 
new_gameboard.gameboard[0,0] = 'f' 
new_gameboard.display_gameboard
new_gameboard.update_gameboard(first_knight.knight_moves([7,7],[0,0]))
puts "s marks the start, f marks the finish, and k marks the shortest path moves inbetween"
new_gameboard.display_gameboard