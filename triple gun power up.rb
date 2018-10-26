class TripleGunPowerUp

    attr_reader :x, :y, :width, :height
    attr_accessor :y
    
    def initialize(the_window, x, y)
        @x = x
	    @y = y
        @width = 80
	    @height = 80
	    @image = Gosu::Image.new(the_window, "triple gun power up.png")
    end

    def draw 
        @image.draw_rot(@x, @y, 3, 180)
    end
	
	def movedown
		@y += 10
	end
end