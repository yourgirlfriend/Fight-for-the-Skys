class Rocket

    attr_reader :x, :y, :width, :height, :angle
    attr_accessor :y, :x, :angle
    def initialize(the_window, x_position, y_position)
        @x_position = x_position
	    @y_position = y_position
	    @y = @y_position
	    @x = @x_position + 10
	    @width = 32
	    @height = 32
	    @image = Gosu::Image.new(the_window, "rocket.png")
		@image2 = Gosu::Image.new(the_window, "rocket2.png")
		@counter = 0
        @angle = 0
    end

    def draw
	   @image.draw_rot(@x, @y, 10, @angle) 
    end

    def shoot
        @y -= 6
    end

end
