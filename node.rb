class Node
    attr_accessor :location, :neighbors, :parent, :children, :moves, :parents_array
    
    def initialize(location, parent = nil)
      @location = location
      @neighbors = []
      @parent = nil
    end
  
  end