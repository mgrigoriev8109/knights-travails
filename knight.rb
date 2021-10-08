require_relative "node"

class Knight
  attr_accessor :location, :neighbors, :shortest_moves_array

  def initialize(location)
    @shortest_moves_to_destination = 60
    @shortest_moves_array = []
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

  def create_children_tree(current_node)
    current_node.neighbors = generate_neighbors(current_node.location)
    current_node.neighbors.each {|neighbor|
      child = Node.new(neighbor)
      child.parent = current_node
      child.moves = current_node.moves + 1
      child.parents_array.push(current_node.location)
      current_node.children.push(child)
    }
  end

  def knight_moves(location, destination, root = Node.new(location), discovered_locations = [root], queued_locations = [], array_of_values = [])
    if discovered_locations.empty?
      shortest_path_locations
    elsif root.location == destination
      @shortest_moves_to_destination = shortest_path_locations
    elsif root.moves < shortest_path_locations.length
      root.neighbors = generate_neighbors(location)
      create_children_tree(root)
      iterate_through_arrays(discovered_locations, queued_locations, shortest_path_locations)
      discovered_locations = queued_locations
      queued_locations = []
      level_order_recursive(location, destination, root, discovered_locations, queued_locations, shortest_path_locations)
    end
    shortest_path_locations
  end

  def iterate_through_arrays(discovered_locations, queued_locations, path_locations)
    discovered_locations.each do |node|
      unless node.nil? 
        queued_locations.push(node.neighbors)
        path_locations.push(node.location)
      end
    end
  end

  def knight_moves(location, destination)
    if location == destination
      @shortest_moves_to_destination = current_node.moves
      @shortest_moves_array.clear
      until current_node.parent == nil do 
        @shortest_moves_array.push(current_node.location)
        current_node = current_node.parent
      end

    else
      create_children_tree(current_node)
      current_node.children.each do |child|
        unless child.moves > @shortest_moves_to_destination || child.parents_array.include?(child.location)
          knight_moves(child.location, destination, child)
        end
      end
    end
  end

end


first_knight = Knight.new([0,0])
first_knight.knight_moves([0,0],[1,2],Node.new([0,0]))
p first_knight.shortest_moves_array