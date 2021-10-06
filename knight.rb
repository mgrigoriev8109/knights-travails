class Knight
  attr_accessor :moves

  def initialize
    @moves = []
  end

  def knight_moves(start, end)
    if current_node.location == end
      return least moves_traveled
    else
      moves_traveled += 1
      @moves.each do 
        moves_traveled = knight_moves(current_node, end)
      end
    end
    moves_traveled
  end

end