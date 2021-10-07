class Node
  attr_accessor :location, :neighbors, :parent, :children
  
  def initialize(location, parent = nil)
    @location = location
    @neighbors = generate_neighbors(location)
    @parent = parent
    @children = []
  end

  def generate_neighbors(location)
    neighbors = []
    neighbors.push([location[0] + 2, location[1] + 1])
    neighbors.push([location[0] + 2, location[1] - 1])
    neighbors.push([location[0] - 2, location[1] + 1])
    neighbors.push([location[0] - 2, location[1] - 1])
    neighbors.push([location[0] + 1, location[1] + 2])
    neighbors.push([location[0] + 1, location[1] - 2])
    neighbors.push([location[0] - 1, location[1] + 2])
    neighbors.push([location[0] - 1, location[1] - 2])
    neighbors.select!{ |neighbor| 
      neighbor.all?{ |number|
        number <= 8 && number >= 0
      }
    }
    neighbors
  end
end

class Knight
  attr_accessor :location, :neighbors, :shortest_moves_array

  def initialize(location)
    @shortest_moves_to_destination = 64
  end

  def knight_moves(location, destination, moves, node)
    if location == destination
      @shortest_moves_to_destination = moves
    else
      moves += 1
      unless moves < @shortest_moves_to_destination
        current_location_node = Node.new(location)
        create_children_tree(generate_possible_moves(location), node)
        knight_moves(move, destination, moves)
      end
    end
  end

  def create_children_tree(root, neighbors)
    neighbors.each {|neighbor|
      child = Node.new(neighbor)
      child.parent = root
      root.children.push(child)
    }
  end
end


first_knight = Knight.new([0,0])
starting_node = Node.new([0,0])
p starting_node.neighbors
p starting_node.children
first_knight.create_children_tree(starting_node, starting_node.neighbors)
p starting_node.children