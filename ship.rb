class Ship
    
    attr_reader :x, :y, :height, :width
	attr_reader :x, :y, :width, :height, :dead, :iswallleft, :iswallright
    attr_accessor :image, :x_velocity, :x, :y
     
    def initialize()
        @x = 400
        @y = 800
	    @y_velocity = 10
	    @width = 71
	    @height = 120
		@dead = false
		@frameshipanimcounter = 0
		@framer = 0
		@image_array = Gosu::Image.load_tiles("f18.png", 71, 120)
		@image = @image_array[@framer]
		@iswallright  = false
		@iswallleft = false
		#@deathsound = Gosu::Sample.new("ded.ogg")
		@dedlay = false
		@frameshipdeadcounter = 0
		@deadframer = 0
		@fflfblarg = false
		@dodraw == true
		@counter = 0
		@angle = 0
    end

	
    def draw
    if @dead != true
		@frameshipanimcounter += 1
		if @frameshipanimcounter == 6 && @framer % 2 == 0
		  @framer += 1
		  @image = @image_array[@framer % 2]
		  @image.draw(@x, @y, 2)
		  @frameshipanimcounter = 0
		elsif @frameshipanimcounter == 6 && @framer % 2== 1
		  @framer += 1
		  @image = @image_array[@framer % 2]
		  @image.draw(@x, @y, 2)
		  @frameshipanimcounter = 0
		else
		  @image.draw(@x, @y, 2)
		end
	elsif @dead == true
	  @image = @image_array[@deadframer]
	  @frameshipdeadcounter += 1
	  if @frameshipdeadcounter == 5
	    @frameshipdeadcounter = 0
		@deadframer += 1 unless @fflfblarg == true
		if @deadframer == @image_array.length - 1
		  @fflfblarg = true
		  @dodraw = false
		end
	  end
	end
	@image.draw(@x, @y, 2) unless @dodraw == false
    end

	def die(the_window)
		@frameshipanimcounter = -10000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
		@image_array = Gosu::Image.load_tiles("Explosion.png", 157, 229)
		@x_velocity = 0
		@dead = true
		#@deathsound.play unless @dedlay == true
		#muse.stop
		@dedlay = true
	end
  
    def moveleft
        @x -= 8
        if @x <= 0
	        @x = 0
	    end
    end
  
    def moveright
        @x += 8
	    if @x >= 730
	        @x = 730
	    end
    end

    def moveup
        @y -= 8
        if @y <= 0
	        @y = 0
	    end
    end
  
    def movedown
        @y += 8
	    if @y >= 950
	        @y = 950
	    end
    end
end