class EnemyShip
    
    attr_reader :x, :width, :height, :x_velocity, :y_velocity
    attr_accessor :y, :is_destroyed, :x, :x_velocity, :y_velocity
	@is_destroyed = false
   
   def initialize(the_window, x, y)
        @x = x
	    @y = y
        @width = 80
	    @height = 80
	    num = rand(0..2)
		@dead = false
		@x_velocity = 2
		@y_velocity = 5
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
	    if num == 0
			@image_array = Gosu::Image.load_tiles("double_engin_forward_swept_wings.png", 78, 121)
	    elsif num == 1
			@image_array = Gosu::Image.load_tiles("rear_wing_plane.png", 79, 141)
        else num == 2
			@image_array = Gosu::Image.load_tiles("single_engin_forward_swept_wings.png", 79, 156)
	    end
		@counter = 0.0
        @counter_two = 0.0
    end
	
	def blowup
		@image_array = Gosu::Image.load_tiles("Explosion.png", 157, 229)
		@is_destroyed = true
	end
  
	def bounce
		if @x <= 0
		  	@x_velocity *= -1
		elsif @x >= 750
		   	@x_velocity *= -1
		end
	end

	def move
			@x = @x + @x_velocity
			@y = @y + @y_velocity
	end
     
    def draw
    if @dead != true
		@frameshipanimcounter += 1
		if @frameshipanimcounter == 6 && @framer % 2 == 0
		  @framer += 1
		  @image = @image_array[@framer % 2]
		  @image.draw(@x, @y, 200)
		  @frameshipanimcounter = 0
		elsif @frameshipanimcounter == 6 && @framer % 2== 1
		  @framer += 1
		  @image = @image_array[@framer % 2]
		  @image.draw(@x, @y, 200)
		  @frameshipanimcounter = 0
		else
		  @image.draw(@x, @y, 200)
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
		@image.draw(@x, @y, 200) unless @dodraw == false
    end
end