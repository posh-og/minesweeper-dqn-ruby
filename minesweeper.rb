class Minesweeper
    attr_accessor :level, :dimensions, :board, :hidden, :timer, :flagged_positions
  
    include MinesHelper

    NORTH = [0, 1]
    SOUTH = [0, -1]
    WEST = [-1, 0]
    EAST = [1, 0]
    DIRECTIONS = [NORTH, SOUTH, EAST, WEST]
    # takees in level as a string(easy, medium or hard)
    # dimensions is 1d array of 2 values, containting length and wisth
    # mines is the total number of mines for the board(have to add checks to test validity of the board before implementing)
    def initialize(level, dimensions, mines)
        # Initialize attributes
        @level = level
        @dimensions = dimensions
        @board = Array.new(dimensions[0]) { Array.new(dimensions[1], 0) }
        @hidden = Array.new(dimensions[0]) { Array.new(dimensions[1], true) }
        @timer = Timer.new
        @flagged_positions = []

        # Generate mines and numbers
        create(mines)
    end
  
    def create(mines)
      # Generate mines randomly, ensuring the first click and surrounding tiles are safe
      safe_tiles = [[0, 0], [0, 1], [0, -1], [1, 0], [-1, 0]]  # Adjust based on click logic
      until mines == 0
        row = rand(dimensions[0])
        col = rand(dimensions[1])
        if !mine?(row, col) && !safe_tiles.include?([row, col])
          @board[row][col] = 9  # Represent mines with 9
          mines -= 1
        end
      end
  
      # Assign numbers to tiles based on adjacent mines
      (0...dimensions[0]).each do |row|
        (0...dimensions[1]).each do |col|
          next if mine?(row, col)
          @board[row][col] = count_adjacent_mines(row, col)
        end
      end
    end
  
    # ... (click, flag, flick, and helper methods as defined in the spec)
  end

  def click(row, col)
    # Check tile status
    # Reveal tile value
    # Handle mine explosion or zero tile opening (DFS)
  end
  
  def click(row, col)
    if hidden?(row, col) && !flagged?(row, col)
      @hidden[row][col] = false
      if mine?(row, col)
        # Handle mine explosion (game over)
        return -1
      else
        if @board[row][col] == 0
          Search_DFS_till_numbered_tiles(row, col)
        end

        # Check for victory
        if all_non_mine_tiles_opened?
          return 10
        else
          return 0
        end
      end
    end
  end

  def all_non_mine_tiles_opened?
    mines_count = @board.flatten.count(&:mine?)  # Count mines on the board
    hidden_mines_count = @hidden.flatten.count(&@board.method(:mine?))  # Count hidden mines
    mines_count == hidden_mines_count && @hidden.flatten.none? { |h| h && !mine?(@board[h]) }  
  end
  
  def flag(row, col)
    # Toggle flag status at the specified position
  end

  def flick(row, col)
    # Check if the tile is opened and numbered
    # Verify surrounding flags and execute appropriate actions
  end

  def search_DFS_till_numbered_tiles(row, col)
    opened_tiles = []
    stack = [[row, col]]
  
    while !stack.empty?
      row, col = stack.pop
      next if !hidden?(row, col) || flagged?(row, col)
  
      @hidden[row][col] = false
      opened_tiles << [row, col]
  
      if @board[row][col] == 0
        DIRECTIONS.each do |drow, dcol|
          new_row = row + drow
          new_col = col + dcol
          if dimensions.include?(new_row) && dimensions.include?(new_col)
            stack.push([new_row, new_col])
          end
        end
      end
    end
    opened_tiles
  end
end

mines_game = Minesweeper.new('easy', [10,10], 10)
mines_game.click(0,0)
mines_game.train_using_dqn()