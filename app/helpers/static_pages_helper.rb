module StaticPagesHelper
    def tweetmark_title(count)
       if count == 1
           return "tweetmark"
        else
            return "tweetmarks"
        end 
    end
end
