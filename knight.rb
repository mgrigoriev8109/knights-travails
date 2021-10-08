require_relative "node"

class Knight
  attr_accessor :visited_array, :shortest_moves_to_destination, :shortest_moves_array

  def initialize
    @shortest_moves_to_destination = 60
    @shortest_moves_array = []
    @visited_array = []
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

  end

  def create_children_nodes(current_node)
    
    current_node.neighbors = generate_neighbors(current_node.location)
    current_node.neighbors.each do |neighbor|
      unless @visited_array.include?(neighbor)
        child = Node.new(neighbor)
        @visited_array.push(neighbor)
        child.parent = current_node
        child.moves = current_node.moves + 1
        child.parents_array.push(current_node.location)
        current_node.children.push(child)
      end
    end
  end

  def check_for_destination(discovered_locations, destination, queued_locations)
    discovered_locations.each do |node|
      if node.location == destination
        @shortest_moves_array.clear
        until node.parent.nil?
          @shortest_moves_array.push(node)
          node = node.parent
        end
      else
        queued_locations.push(node.children)
      end
    end
    discovered_locations.clear
  end

  def knight_moves(location, destination, root = Node.new(location), discovered_locations = [root], queued_locations = [])
    if discovered_locations.empty?
      @shortest_moves_array
    else 
      discovered_locations.each do |discovered_node|
        create_children_nodes(discovered_node)
      end
      check_for_destination(discovered_locations, destination, queued_locations)
      discovered_locations = queued_locations
      queued_locations = []
      knight_moves(location, destination, discovered_locations, queued_locations)
    end
  end
end

first_knight = Knight.new
first_knight.knight_moves([0,0],[3,3])
p first_knight.shortest_moves_array