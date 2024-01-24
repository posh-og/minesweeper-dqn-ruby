module MinesHelper

    def mine?(row, col)
        self.board[row][col] == 9  # Access board using self
    end

    def not_a_mine?(row,col)
        !mine?(row, col)
    end

    def opened?(row,col)
        !hidden?(row,col)
    end
    
    def numbered?(row,col)
        (not_a_mine?(row,col)? && opened?(row,col))
    end
    
    def flagged?(row,col)
        self.flagged_positions.include?([row,col])
    end
    
    def hidden?(row,col)
        self.hidden[row][col]
    end
    
    def unflagged?(row,col)
        !flagged(row,col)
    end
    
    def go_easy_on_user?
        level == 'easy'
    end

    # more helpers  
    # ... other helper methods as defined in the spec
      
end