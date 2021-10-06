I'm going to be using graphs to create a method that shows:

the simplest possible way to get from one square of a chess board to another by:

outputting all the squares the knight will stop on along the way
  - An example: knight_moves([0,0],[1,2]) == [[0,0],[1,2]]
  - Another example: knight_moves([0,0],[3,3]) == [[0,0],[1,2],[3,3]]

first create a game board using a game board class
  -two dimentional array? []
    -@@gameboard_side= 8
    -Array.new(gameboard_side){Array.new(gameboard_side)}

then create a knight using a knight class

treat all possible moves the knight can make as children in a tree
  - don't allow any moves to go off the board
  - use undirected graph and find shortest part between two vertices (nodes/array points)

decide which algorithm is best to use for this case
  - depth first search because it's far away? 
    -Recursively get to the end point, adding steps += 1 each recursive call
    -return the array nodes hit on the shortest path (least steps) when returning recursions

use the chosen algorithm to find the shortest path between starting node and ending node
  - output what the full path looks like

