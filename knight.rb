class Node
  attr_accessor :location, :neighbors, :parent
  
  def initialize(location, parent = nil)
    @location = location
    @neighbors = []
    @parent = parent
  end
end

class Knight
  attr_accessor :location, :neighbors, :shortest_moves_array

  def initialize(location)
    @shortest_moves_to_destination = 64
  end

  def knight_moves(location, destination, moves)
    if location == destination
      @shortest_moves_to_destination = moves
    else
      moves += 1
      
      unless moves < @shortest_moves_to_destination
        knight_moves(move, destination, moves)
      end
    end
  end

def generate_possible_moves(location)
    possible_moves = []
    possible_moves.push([location[0] + 2, location[1] + 1])
    possible_moves.push([location[0] + 2, location[1] - 1])
    possible_moves.push([location[0] - 2, location[1] + 1])
    possible_moves.push([location[0] - 2, location[1] - 1])
    possible_moves.push([location[0] + 1, location[1] + 2])
    possible_moves.push([location[0] + 1, location[1] - 2])
    possible_moves.push([location[0] - 1, location[1] + 2])
    possible_moves.push([location[0] - 1, location[1] - 2])
    possible_moves.select!{ |move| 
      move.all?{ |number|
        number <= 8 && number >= 0
      }
    }
    possible_moves
  end

end



first_knight = Knight.new([0,0])
first_knight.generate_possible_moves([0,0])
first_knight.knight_moves([3,3],[0,0])
p first_knight.shortest_moves_array