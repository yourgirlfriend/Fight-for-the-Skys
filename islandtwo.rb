class IslandTwo
    
    attr_reader :xxxx, :width, :height
    attr_accessor :yyyy
    
    def initialize(the_window, xxxx, yyyy)
        @xxxx = xxxx
	    @yyyy = yyyy
        @width = 80
	    @height = 80
	    @image = Gosu::Image.new(the_window, "islandtwo.png")
    end

    def draw 
        @image.draw(@xxxx, @yyyy, 1)
    end
end