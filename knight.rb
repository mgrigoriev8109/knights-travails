class Knight
  attr_accessor :location, :shortest_moves_array

  def initialize(location)
    @location = location
    @shortest_moves_array = Array.new(100)
  end

  def knight_moves(location, destination, current_moves_array = [])

    if location == destination
      if current_moves_array.length < @shortest_moves_array.length
        @shortest_moves_array = []
        @shortest_moves_array.concat(current_moves_array)
      end
    else
      possible_moves = generate_possible_moves(location)
      possible_moves.each do  |move|
        unless current_moves_array.include?(move)
          current_moves_array.push(move)
          knight_moves(move, destination, current_moves_array)
        end
      end
    end
    @shortest_moves_array
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
p first_knight.knight_moves([0,0],[8,6])