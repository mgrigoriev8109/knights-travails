class Node
    attr_accessor :location, :neighbors, :parent, :children, :moves, :parents_array
    
    def initialize(location, parent = nil)
      @location = location
      @neighbors = []
      @parent = nil
      @children = []
      @parents_array = []
      @moves = 0
      @visited = false
    end
  
  end