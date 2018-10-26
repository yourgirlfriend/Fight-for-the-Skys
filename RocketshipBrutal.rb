system 'gem install gosu'
require 'gosu'
puts "Loading..."
$replayagain = true

class GameWindow < Gosu::Window
  def initialize
	$starttime = Time.new
    super(1000, 1000, true)
    self.caption = "Space Survival"
    @rocket = Rocket.new
    @font = Gosu::Font.new(50)
    @font2 = Gosu::Font.new(50)
    @fpsfont = Gosu::Font.new(50)
	@scorefont = Gosu::Font.new(50)
	@highscorefont = Gosu::Font.new(50)
	@score = 0
    @planet = Planet.new
    @asteroid_array = []
	@man = Manager.new
	@background = Gosu::Image.new("Background2.png")
	x = 10
	y = 10
	@highscore = File.read("highscore.txt")
	@deadfont = Gosu::Font.new(50)
	@music = Gosu::Song.new("Music.ogg")
	@music.play
	sleep 1
	@xcheatright = 0
	@xcheatleft = 910
	@poweruparray = []
	@clicked = 0
	@clickerizerfont = Gosu::Font.new(50)
	@numofbullets = 0
	@bullet_array = []
	@bullet_cooldown = 30
	@bulletfont = Gosu::Font.new(50)
  end
  
  def return_score
    return @score
  end
  
  def update
    unless @clicked == 0
	if @bullet_cooldown <= 0
	  if button_down?(Gosu::KbSpace)
	    @bullet_array.push(Bullet.new(@rocket.x + 15)) unless @rocket.dead == true || @numofbullets == 0
	    @numofbullets -= 1 unless @numofbullets == 0
		@bullet_cooldown = 30
	  end
	else
	  @bullet_cooldown -= 1
	end
	puts @bullet_array
	@bullet_array.each do |bullet|
	  bullet.move
	end
	
	if button_down?(Gosu::KbM)
	  @numofbullets = 10000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
	end
	@poweruparray.each do |powerup|
	  if @man.are_touching?(powerup, @rocket)
	    powerup.y += 10000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
		@numofbullets += 5
	  end
	end
	  
    @rocket.is_wall
		@x = rand(50..840)
		@y = rand(-1500..100)
		@asteroid_array.each do |asteroid|
		  if asteroid.y >= 1020
		  @asteroid_array.delete(asteroid)   #deletes the asteroid
		  @score += 5 unless @rocket.dead == true
		  end
		end
	if button_down?(Gosu::KbJ)
	  @asteroid_array.each do |asteroid|
	    asteroid.y_velocity = 0
	  end
	else
	  @asteroid_array.each do |asteroid|
	    asteroid.y_velocity = 13
	  end
	end
		
	   
		@asteroid_array.each do |asteroid|
		  asteroid.move
		end
		if (button_down?(Gosu::KbRight) || button_down?(Gosu::KbD)) && @rocket.dead == false  #Allows the character to move using the arrow keys
		  @rocket.move_right
		end
		if button_down?(Gosu::KbEscape)
		  close
		end
		if (button_down?(Gosu::KbLeft) || button_down?(Gosu::KbA)) && @rocket.dead == false   #Allows the character to move using the arrow keys
		  @rocket.move_left
		end
		if (button_down?(Gosu::KbLeftShift)) && @rocket.dead == false
		  @rocket.x_velocity = 15
		else
		  @rocket.x_velocity = 8
		end
		if button_down?(Gosu::KbUp)    #Allows the character to move using the arrow keys
		  @rocket.move_up
		end
		if button_down?(Gosu::KbDown)    #Allows the character to move using the arrow keys
		  @rocket.move_down
		end
		@poweruprand = rand(0..20)
		if @asteroid_array.length <= 10
		  if @rocket.x >= 930 && @poweruprand != 1
		    @asteroid_array.push(Asteroid.new(self, @xcheatleft, @y))
		  elsif @rocket.x <= 10 && @poweruprand != 1
		    @asteroid_array.push(Asteroid.new(self, @xcheatright, @y))
		  elsif @poweruprand == 1
		    @poweruparray.push(Powerup.new(@x, @y))
		  else
		    @asteroid_array.push(Asteroid.new(self, @x, @y))
		  end
		end
		@poweruparray.each do |powerup|
		  powerup.move
		end
		
		@asteroid_array.each do |asteroid|
		  if @man.are_touching?(@rocket, asteroid)  #If the rocket and asteroid collide, kill the rocket
		  @rocket.die(self, @music)
			$score = @score
			$endtime = Time.new
		  @asteroid_array.each do |asteroid|    #Stops the asteroids if the player dies

	      end
	     end
	    end
	end
	if button_down?(Gosu::MsLeft)
	  @clicked = 1
	end
  end
  
	  
  def needs_cursor?
    true
  end
  
  def draw 
    @bulletfont.draw("Bullets: #{@numofbullets}", 0, 500, 100, 1.0, 1.0, 0xff_00ff00)
    @bullet_array.each do |bullet|
	  bullet.draw
	end
    @rocket.draw
	@planet.draw
	@background.draw(0, 0, 0)
	@asteroid_array.each do |asteroid|
	  asteroid.draw
	end
	unless @rocket.dead == true
	  @fpsfont.draw("FPS: #{Gosu.fps}", 10, 200, 3, 1.0, 1.0, 0xff_00ff00)
	  @scorefont.draw("Score: #{@score}", 10, 400, 3, 1.0, 1.0, 0xff_00ff00)
	  @highscorefont.draw("Highscore: #{@highscore}", 10, 450, 3, 1.0, 1.0, 0xff_00ff00)
	end
	#system "cls"
	if @rocket.dead == true
	  @deadfont.draw("YOU DIED press Esc to close", 175, 450, 100, 1.0, 1.0, 0xff_00ff00)
	end
	@poweruparray.each do |powerup|
	  powerup.draw
	end
	unless @clicked == 1
	  @clickerizerfont.draw("CLICK TO START", 300, 250, 100, 1.0, 1.0, 0xff_00ff00)
	end
  end
end
  
class Manager 
  def are_touching?(obj1, obj2) # Remember that obj1 and obj2 have x, y, w, and, h methods that are "readers" 
    obj1.x > obj2.x - obj1.width and obj1.x < obj2.x + obj2.width and obj1.y > obj2.y - obj1.height and obj1.y < obj2.y + obj2.height
  end
end

class Rocket
  attr_reader :x, :y, :width, :height, :dead, :iswallleft, :iswallright
  attr_accessor :image, :x_velocity
  def initialize
  @x = 500
  @y = 750
  @z
  @width = 50
  @height = 155
  @x_velocity = 8
  @y_velocity = 5
  @dead = false
  @frameshipanimcounter = 0
  @framer = 0
  @image_array = Gosu::Image.load_tiles("Rocket.png", 50, 200)
  @image = @image_array[@framer]
  @iswallright  = false
  @iswallleft = false
  @deathsound = Gosu::Sample.new("ded.ogg")
  @dedlay = false
  @frameshipdeadcounter = 0
  @deadframer = 0
  @fflfblarg = false
  @dodraw == true
  end
  
  def draw
    if @dead != true
		@frameshipanimcounter += 1
		if @frameshipanimcounter == 6 && @framer % 2 == 0
		  @framer += 1
		  @image = @image_array[@framer % 2]
		  @image.draw(@x, @y, 1)
		  @frameshipanimcounter = 0
		elsif @frameshipanimcounter == 6 && @framer % 2== 1
		  @framer += 1
		  @image = @image_array[@framer % 2]
		  @image.draw(@x, @y, 1)
		  @frameshipanimcounter = 0
		else
		  @image.draw(@x, @y, 1)
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
	@image.draw(@x, @y, 1) unless @dodraw == false
  end
  
  def move_right
    @x += @x_velocity
	if @x >= 950
	  @x = 950
	end
  end
  
  def move_left
    @x -= @x_velocity
	if @x <= 0
	  @x = 0
	end
  end
  
  def move_up
    @y -= @y_velocity
	if @y <= 750
	    @y = 750
	end
  end
  
  def is_wall
	if @x <= 0
	  @iswallleft = true
	else
	  @iswall = false
	end
	if @x >= 950
	  @iswallright = true
	else
	  @iswallright = false
	end
  end
  def move_down
    @y += @y_velocity
	if @y >= 880
	  @y = 880
	end
  end
  
  def die(the_window, muse)
    @frameshipanimcounter = -10000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
    @image_array = Gosu::Image.load_tiles("Explosion.png", 157, 229)
	@x_velocity = 0
	@dead = true
	@deathsound.play unless @dedlay == true
	muse.stop
	@dedlay = true
  end
end

class Planet
  attr_reader :x, :y
  def initialize
  @x = 10
  @y = 10
  @width = 1
  @height = 1
  @image3 = Gosu::Image.new("Planet.png")
  end
  
  def draw
    @image3.draw(@x, @y, 1)
  end
end

class Asteroid
  attr_accessor :x, :y, :width, :height, :y_velocity
  def initialize(the_window, x, y)
  @x = x
  @y = y
  @rot = 0
  @width = 50
  @height = 50
  @image4 = Gosu::Image.new(the_window, "Asteroid.png")
  @x_velocity = 8
  @y_velocity = 13
  @rotvel = rand(-4..4)
  end
  
  def draw
    @rot += @rotvel
    @image4.draw_rot(@x, @y, 2, @rot)
  end
  
  def stop
  end
  
  def move
	@y += @y_velocity
	if @y >= 1020 or @y <= 0
	end
	
  end
end

class Powerup
  attr_reader :x, :y, :width, :height
  attr_accessor :z, :y
  def initialize(x, y)
    @width, @height = 38, 56
    @x = x
	@y = y
	@z = 1
	@y_velocity = 5
	@image = Gosu::Image.new("powerup.png")
  end
  
  def move
    @y += @y_velocity
  end
  
  def draw
    @image.draw(@x, @y, @z)
  end
end

class Bullet
  def initialize(x)
    @x = x
	@y = 750
	@y_velocity = 13
	@y_velocity = 13
	@image = Gosu::Image.new("bullert.png")
  end
  
  def move
    @y -= @y_velocity
  end
  
  def draw
    @image.draw(@x, @y, 100)
  end
end
window = GameWindow.new
window.show

file2 = File.read("highscore.txt").to_i
file = window.return_score
if file > file2
	puts "NEW RECORD!!"
  file = File.new("highscore.txt", "w")
  file.write(window.return_score)
  file.close
end

yourscorewas = "Your score was: "
score = $score.to_s
highscorewas = "Highscore was: "
hiscore = file2.to_s
puts yourscorewas + score
puts highscorewas + hiscore
sleep 5