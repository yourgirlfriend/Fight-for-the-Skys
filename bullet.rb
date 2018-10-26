class Bullet
    
    attr_reader :x, :y, :width, :height
  
    def initialize(the_window, x_position, y_position) 
        @x_position = x_position
	    @y_position = y_position
	    @y = @y_position
	    @x = @x_position - 10
	    @width = 32
	    @height = 32
	    @image = Gosu::Image.new(the_window, "bullet.bmp")
    end
  
    def draw
        @image.draw(@x, @y, 1) 
    end
  
    def shoot
        @y -= 10
    end
  
end