class PlayerLives
    
    attr_reader :x, :y, :width, :height

    def initialize() 
	    @y = 930
	    @x = 700
	    @width = 69
	    @height = 113
	    @image = Gosu::Image.new("f18 lives.png")
    end
  
    def draw
		@image.draw(@x, @y, 5,)
    end
  
end