class Knight
  attr_accessor :moves

  def initialize
    @possible_moves = generate_possible_moves
  end

  def knight_moves(start, destination)
    if current_node.location == destination
      return least moves_traveled
    else
      moves_traveled += 1
      @possible_moves.each do 
        moves_traveled = knight_moves(current_node, destination)
      end
    end
    moves_traveled
  end

  def generate_possible_moves(location)
    function that takes a point on a 2d array
    and creates an array of possible end-points
    given that a knight can move two one way one another way

    todo this
  end

end