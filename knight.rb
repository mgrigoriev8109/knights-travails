class Node
  attr_accessor :location, :neighbors, :parent, :children
  
  def initialize(location, parent = nil)
    @location = location
    @neighbors = generate_neighbors(location)
    @parent = parent
    @children = []
    @parents_array = []
    @moves = 0
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

  def knight_moves(location, destination)
    if location == destination
      @shortest_moves_to_destination = moves
    else
      current_location_node = Node.new(location)
      create_children_tree(current_location_node)
      current_location_node.children.each { |child|
        unless child.moves > @shortest_moves_to_destination || child.parents_array.include?()
          knight_moves(child.location, destination)
        end
      }
    end
  end

  def create_children_tree(current_location_node)
    current_location_node.neighbors.each {|neighbor|
      child = Node.new(neighbor)
      child.parent = current_location_node
      child.moves = current_location_node.moves + 1
      child.parents_array.push(root.location)
      current_location_node.children.push(child)
    }
  end
end


first_knight = Knight.new([0,0])
first_knight.knight_moves([0,0],[1,2])