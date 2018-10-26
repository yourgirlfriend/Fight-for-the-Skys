class Explosion
	
	attr_accessor :x, :y
	
	def initialize(x, y)
		#@sound = Gosu::Sample.new("ded.ogg")
		@x = x
		@y = y
		@z = 40
		@loopthrough = 0
		@framer = 1
		@image_array = Gosu::Image.load_tiles("Explosion.png", 157, 229)
		#@sound.play
	end
  
	def draw
		@loopthrough += 1
		if @loopthrough == 6 && @framer != 19
			@framer += 1
			@loopthrough = 0
		elsif @framer == 19
			@z = -32
		end
		@image_array[@framer - 1].draw(@x, @y, @z)
	end
end