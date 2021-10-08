class GameBoard

  attr_accessor :gameboard

  def initialize(gameboard = [])
    @gameboard = gameboard
  end

  def create_gameboard
    @gameboard = [Array.new(8, "x"){Array.new(8, "x")}]
  end

  def display_gameboard
    @gameboard.each do |space|
      puts space.join(" ")
    end
  end

end

new_gameboard = GameBoard.new
new_gameboard.create_gameboard
new_gameboard.display_gameboard
p new_gameboard.gameboard[0][0]