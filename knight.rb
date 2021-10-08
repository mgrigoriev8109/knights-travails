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

  def create_children_nodes(current_node)
    current_node.neighbors = generate_neighbors(current_node.location)
    current_node.neighbors.each {|neighbor|
      unless visited_array.include?(neighbor)
        child = Node.new(neighbor)
        @visited_array.push(neighbor)
        child.parent = current_node
        child.moves = current_node.moves + 1
        child.parents_array.push(current_node.location)
        current_node.children.push(child)
      end
    }
  end

  def knight_moves(location, destination, root = Node.new(location), discovered_locations = [root], queued_locations = [], array_of_values = [])
    if discovered_locations.empty?
      shortest_path_locations
    else 
      root.neighbors = generate_neighbors(location)
      create_children_nodes(root)
      #now we have 1,2 and 2,1 as root.children, and have moved once to get there
      #the current discovered_locations is just root, so we have to iterate through root and check if it's the destination
      check_for_destination(discovered_locations, destination)
      discovered_locations = queued_locations
      queued_locations = []
      level_order_recursive(location, destination, root, discovered_locations, queued_locations, shortest_path_locations)
    end
    shortest_path_locations
  end

  def check_for_destination(discovered_locations, destination)
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