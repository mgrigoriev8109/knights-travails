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

  def update_gameboard_with_path(array)
    array.each do |node_on_path|
      @gameboard(node_on_path) = k
    end
  end

end

new_gameboard = GameBoard.new
new_gameboard.create_gameboard
new_gameboard.update_gameboard(knight_moves([7,7],[0,0]))
new_gameboard.display_gameboard
p new_gameboard.gameboard