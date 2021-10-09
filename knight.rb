require_relative "node"

class Knight
  attr_accessor :visited_array, :shortest_moves_array

  def initialize
    @shortest_moves_array = []
    @visited_array = []
  end

  def knight_moves(location, destination, discovered_locations = [Node.new(location)], queued_locations = [])
    if @shortest_moves_array.length > 0
      @shortest_moves_array
    else 
      discovered_locations.each do |discovered_node|
        create_children_nodes(discovered_node, queued_locations)
      end
      check_for_destination(discovered_locations, destination)
      discovered_locations = queued_locations
      queued_locations = []
      knight_moves(location, destination, discovered_locations, queued_locations)
    end
    @shortest_moves_array
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

  def create_children_nodes(current_node, queued_locations)
    current_node.neighbors = generate_neighbors(current_node.location)
    current_node.neighbors.each do |neighbor|
      unless @visited_array.include?(neighbor)
        child = Node.new(neighbor)
        @visited_array.push(neighbor)
        child.parent = current_node
        queued_locations.push(child)
      end
    end
  end

  def check_for_destination(discovered_locations, destination)
    discovered_locations.each do |node|
      if node.location == destination
        until node.parent.nil?
          @shortest_moves_array.push(node.location)
          node = node.parent
        end
        p @shortest_moves_array
      end
    end
    discovered_locations.clear
  end

end

first_knight = Knight.new
first_knight.knight_moves([7,7],[0,0])
first_knight.shortest_moves_array

