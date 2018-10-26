class IslandOne
    
    attr_reader :xxx, :width, :height
    attr_accessor :yyy
    
    def initialize(the_window, xxx, yyy)
        @xxx = xxx
	    @yyy = yyy
        @width = 80
	    @height = 80
	    @image = Gosu::Image.new(the_window, "islandone.png")
    end

    def draw 
        @image.draw(@xxx, @yyy, 1)
    end
end