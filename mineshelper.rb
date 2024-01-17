module MinesHelper

    def mine?(row, col)
        self.board[row][col] == 9  # Access board using self
    end

    def not_a_mine?(row,col)
    
    end

    def opened?(row,col)
        same as !hidden?(row,col)
    end
    
    def numbered?(row,col)
        same as (not_a_mine?(row,col)? && opened?(row,col))
    end
    
    def flagged?(row,col)
            
    end
    
    def hidden?(row,col)
        
    end
    
    def unflagged?(row,col)
        !flagged(row,col)
    end
    
    def go_easy_on_user?
        level == easy?
    end

    # more helpers  
    # ... other helper methods as defined in the spec
      
end