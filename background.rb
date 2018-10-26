class Background
    
    attr_reader :xx, :yy, :width, :height
    attr_accessor :yy
    
    def initialize(the_window, xx, yy)
        @xx = xx
	    @yy = yy
        @width = 80
	    @height = 80
	    @image = Gosu::Image.new(the_window, "background.jpg")
    end

    def draw 
        @image.draw(@xx, @yy, 1)
    end
end