#system("gem install gosu")
system("cls")

require 'gosu'
require 'rubygems'
require './ship.rb'
require './enemy_ship.rb'
require './bullet.rb'
require './fireball.rb'
require './rocket.rb'
require './background.rb'
require './islandone.rb'
require './islandtwo.rb'
require './explosion.rb'
require './player lives.rb'

class GameWindow < Gosu::Window
    def initialize()
    super 800, 1080, true
	self.caption = "World War Two: Fight For the Skys"
        @badguy = []
        @bullet_array = []
		@rocket_array = []
		@background_image = []
		@islandone = []
		@islandtwo = []

	    x = 0
	    y = -60000
	    300.times do 
	      @badguy.push(EnemyShip.new(self, x, y))
	      x += rand(1..300)
		  y += rand(1..300)
	      if x > 750
		      y += 300
		      x = 0
		    end
    	end
		
		xx = 0
	    yy = -3100
	    3000.times do 
	      @background_image.push(Background.new(self, xx, yy))
	      xx += 39
	      if xx > 900
		      yy += 34
		      xx = 0
		    end
    	end

		xxx = 200
	    yyy = -2200
	    30.times do 
	      @islandone.push(IslandOne.new(self, xxx, yyy))
	      xxx += 600
	      if xxx > 900
		      yyy += 700
		      xxx = 200
		    end
    	end

		xxxx = 200
	    yyyy = -2000
	    30.times do 
	      @islandtwo.push(IslandTwo.new(self, xxxx, yyyy))
	      xxxx += 600
	      if xxxx > 900
		      yyyy += 1200
		      xxxx = 100
		    end
    	end
       # @song = Gosu::Song.new("roboto.wav")
       # @song.play(true)
		@player_ship = Ship.new
		@player_lives = PlayerLives.new
	    @enemy_ship = EnemyShip.new(self, x, y)
		@background = Background.new(self, x, y)
	    @win_font = Gosu::Font.new(self, Gosu::default_font_name, 50)
	    @num = Gosu::Font.new(self, Gosu::default_font_name, 35)
        @timer = Time.new
        @double_guns = false
        @triple_guns = false
		@rocket_power_up = false
		@timer_two = Time.new
		@counter = 0
		@player_ship_is_dead = false
		@highscore = 988800
		@score = 0
		@close_to_ship = false
		@explosion_array = []
		@counter_two = 0
		@counter_three = 0
		@counter_four = 0
		@counter_five = 0
		@respawn = false
		@player_lives_counter = 3
		@player_lives_only_take_one_life = false
		@counter_six = 0
		@timer_three = Time.new
		@enemy_ship_bullet_array = []
		@rand = rand (0..2)
		@player_lives_counter_two = 0
		@begining_of_game = Gosu::Font.new(self, Gosu::default_font_name, 63)
		@round_one_not_complete = true
        @counter_ten = 0
    end
 
    def are_touching?(obj1, obj2)
        obj1.x > obj2.x - obj1.width and obj1.x < obj2.x + obj2.width and obj1.y > obj2.y - obj1.height and obj1.y < obj2.y + obj2.height
    end
  
    def update
        
        if @round_one_not_complete == false
            @counter_ten += 1
            if @counter_ten == 180
                close
                require './round five.rb'
            end
        end

		if @player_ship_is_dead == true
			@counter_six += 1
			if @counter_six == 120 and @player_lives_only_take_one_life == true
				@player_lives_only_take_one_life = false
				@counter_six = 0
			end
			@counter_four += 1
			if @counter_four >= 120
				@player_ship = Ship.new
				@player_ship_is_dead = false
				@counter_four = 0
				@counter_three = 0
				@respawn = true
			end
		end
		
		@background_image.each do |background|
			if background.yy > 1080
				@background_image.delete(background)
			end
		end

		if @score >= 10
			@round_one_not_complete = false
		end

        if Time.new - @timer_two >= 30 and Gosu::button_down?(Gosu::KbSpace) and Time.new - @timer > 0.1
            @double_guns = true
		end
        
		if Time.new - @timer_two >= 60 and Gosu::button_down?(Gosu::KbSpace) and Time.new - @timer > 0.1
            @triple_guns = true
        end
		
		if Time.new - @timer_two >= 120 and Gosu::button_down?(Gosu::KbSpace) and Time.new - @timer > 0.1
            @rocket_power_up = true
        end

	    if Gosu::button_down?(Gosu::KbEscape)
	        close
	    end
		
		if Gosu::button_down?(Gosu::KbReturn)
			@round_one_not_complete = true
	        @badguy = []
			@bullet_array = []
			@rocket_array = []
			@background_image = []
			@islandone = []
			@islandtwo = []

			x = 0
			y = -60000
			300.times do 
			  @badguy.push(EnemyShip.new(self, x, y))
			  x += rand(1..300)
			  y += rand(1..300)
			  if x > 750
				  y += 300
				  x = 0
				end
			end
			
			xx = 0
			yy = -3100
			3000.times do 
			  @background_image.push(Background.new(self, xx, yy))
			  xx += 39
			  if xx > 900
				  yy += 34
				  xx = 0
				end
			end

			xxx = 200
			yyy = -2200
			30.times do 
			  @islandone.push(IslandOne.new(self, xxx, yyy))
			  xxx += 600
			  if xxx > 900
				  yyy += 700
				  xxx = 200
				end
			end

			xxxx = 200
			yyyy = -2000
			30.times do 
			  @islandtwo.push(IslandTwo.new(self, xxxx, yyyy))
			  xxxx += 600
			  if xxxx > 900
				  yyyy += 1200
				  xxxx = 100
				end
			end
		   # @song = Gosu::Song.new("roboto.wav")
		   # @song.play(true)
			@player_ship = Ship.new
			@player_lives = PlayerLives.new
			@enemy_ship = EnemyShip.new(self, x, y)
			@background = Background.new(self, x, y)
			@win_font = Gosu::Font.new(self, Gosu::default_font_name, 50)
			@begining_of_game = Gosu::Font.new(self, Gosu::default_font_name, 63)
			@num = Gosu::Font.new(self, Gosu::default_font_name, 35)
			@timer = Time.new
			@double_guns = false
			@triple_guns = false
			@rocket_power_up = false
			@timer_two = Time.new
			@counter = 0
			@player_ship_is_dead = false
			@highscore = 988800
			@score = 0
			@close_to_ship = false
			@explosion_array = []
			@counter_two = 0
			@counter_three = 0
			@counter_four = 0
			@counter_five = 0
			@respawn = false
			@player_lives_counter = 3
			@player_lives_only_take_one_life = false
			@counter_six = 0
			@timer_three = Time.new
			@enemy_ship_bullet_array = []
			@rand = rand (0..2)
			@player_lives_counter_two = 0
		end

	
	    if @player_ship_is_dead == false
			if Gosu::button_down?(Gosu::KbRight)
                @player_ship.moveright
	        end
	
	        if Gosu::button_down?(Gosu::KbLeft)
	            @player_ship.moveleft
	        end

			if Gosu::button_down?(Gosu::KbUp)
                @player_ship.moveup
	        end
	
	        if Gosu::button_down?(Gosu::KbDown)
	            @player_ship.movedown
	        end
		end



		@badguy.each do |enemyship|
			if enemyship.y > 0 and enemyship.y < 1080 and Time.new - @timer_three > 0.5
				@enemy_ship_bullet_array.push(FireBall.new(self, enemyship.x + 30, enemyship.y))
	           	@timer_three = Time.new
			end
		end

	
	
	        if Gosu::button_down?(Gosu::KbSpace) and Time.new - @timer > 0.1 and @player_ship_is_dead == false
	            if @double_guns != true and @rocket_power_up != true
			    	@bullet_array.push(FireBall.new(self, @player_ship.x + 24, @player_ship.y))
					@timer = Time.new
				end
				if @double_guns == true and Gosu::button_down?(Gosu::KbSpace) and Time.new - @timer > 0.1 and @triple_guns != true and @rocket_power_up != true
					@bullet_array.push(FireBall.new(self, @player_ship.x + 12, @player_ship.y))
					@bullet_array.push(FireBall.new(self, @player_ship.x + 36, @player_ship.y))
					@timer = Time.new
				end

				if @triple_guns == true and Gosu::button_down?(Gosu::KbSpace) and Time.new - @timer > 0.1 and @rocket_power_up != true
					@bullet_array.push(FireBall.new(self, @player_ship.x + 0, @player_ship.y))
					@bullet_array.push(FireBall.new(self, @player_ship.x + 24, @player_ship.y))
					@bullet_array.push(FireBall.new(self, @player_ship.x + 48, @player_ship.y))
					@timer = Time.new
				end


	        	if Gosu::button_down?(Gosu::KbSpace) and Time.new - @timer > 0.3 and @rocket_power_up == true
	            	@rocket_array.push(Rocket.new(self, @player_ship.x + 18, @player_ship.y))
	           	 	@timer = Time.new
				end
	        end
	
			@rocket_array.each do |rocket|
			@badguy.each do |enemyship|
				if are_touching?(rocket, enemyship)
					@badguy.delete(enemyship)
					@explosion_array.push(Explosion.new(enemyship.x - 20, enemyship.y - 20))
					@rocket_array.delete(rocket)
					@score += 10
				end
			end
     	end
		

	    @bullet_array.each do |fireball|
        fireball.shoot
            @badguy.each do |enemyship|
                if are_touching?(fireball, enemyship)
					@counter += 1
					if @counter >= 3
						@badguy.delete(enemyship)
						@score += 10
						@explosion_array.push(Explosion.new(enemyship.x - 20, enemyship.y - 20))
					end	
					if @counter >= 3
						@counter = 0
					end
					@bullet_array.delete(fireball)
                end
            end
        end
		
	    @badguy.each do |enemyship|
            if are_touching?(enemyship, @player_ship) and @respawn != true
				@player_ship_is_dead = true
				if @player_lives_only_take_one_life == false
					@player_lives_counter -= 1
					@player_lives_only_take_one_life = true
				end
            end
        end	
	  
		@bullet_array.each do |fireball|
		    if fireball.y < 0
		        @bullet_array.delete(fireball)
		    end
		end
		
		@enemy_ship_bullet_array.each do |fireball|
			fireball.enemyshoot
			if are_touching?(fireball, @player_ship) and @respawn != true
				@player_ship_is_dead = true
				if @player_lives_only_take_one_life == false
					@player_lives_counter -= 1
					@player_lives_only_take_one_life = true
				end
            end
		end

		@badguy.each do |enemyship|
			enemyship.y += 5
		end

		@background_image.each do |background|
			background.yy += 0.5
		end

		@islandone.each do |islandone|
			islandone.yyy += 0.5
		end

		@islandtwo.each do |islandtwo|
			islandtwo.yyyy += 0.5
		end
		
		if @rocket_power_up == true
			@bullet_array.each do |rocket|
				rocket.shoot
			end
		end
		
		@counter_two += 1
		if @counter_two == 40
			@counter_two = 0
		end
		
		if @counter_two == 20
			@counter_three += 1
		elsif @counter_two == 40
			@counter_three += 1
		end
		
		if @counter_three < 5 
			@respawn = true
		end

		if @counter_three == 5
			@respawn = false
		end

		if @player_lives_counter == 0
			@player_lives_counter_two += 1
		end
		
    end
  
  def draw
	if @player_lives_counter != 0 and @player_lives_counter_two <= 120 and @round_one_not_complete == true and @round_one_not_complete == true
		if @double_guns == true and Time.new - @timer_two > 30 and Time.new - @timer_two < 33
			@win_font.draw("Double guns Activated! ", 175, 350, 3.0, 1.0, 1.0, 0xff_000000)
		end
	
		if Time.new - @timer_two < 5
			@begining_of_game.draw("Round four: Destroy 250 Ships! ", 0, 350, 3.0, 1.0, 1.0, 0xff_000000)
		end

		if @triple_guns == true and Time.new - @timer_two > 60 and Time.new - @timer_two < 63
			@win_font.draw("Triple guns Activated! ", 175, 350, 3.0, 1.0, 1.0, 0xff_000000)
		end
	
		@win_font.draw("Score: #{@score} ", 0, 1000, 3.0, 1.0, 1.0, 0xff_ff00ff)
		@win_font.draw("High Score: #{@highscore} ", 0 , 0, 3.0, 1.0, 1.0, 0xff_ff00ff)
		@win_font.draw("#{@player_lives_counter} X", 700 , 900, 3.0, 1.0, 1.0, 0xff_ff00ff)
    
		if @counter_two <= 20 and @counter_three <= 4
			@player_ship.draw
		end
	
		if @counter_three > 4
			@player_ship.draw
		end

		@explosion_array.each do |explosion|
			explosion.draw
		end

		if @player_ship_is_dead == true
			@player_ship.die(self)
		end

	
		@rocket_array.each do |rocket|
			rocket.draw
		end

		@player_lives.draw

		@islandone.each do |islandone|
			islandone.draw
		end

		@islandtwo.each do |islandtwo|
			islandtwo.draw
		end

		@badguy.each do |enemyship|
			enemyship.draw
		end
   
		@bullet_array.each do |fireball|
			fireball.draw
		end

		@enemy_ship_bullet_array.each do |fireball|
			fireball.draw
		end
	end
	
	if @player_lives_counter == 0 and @round_one_not_complete == true
		@win_font.draw("You Have lost!! ", 200, 450, 3.0, 1.0, 1.0, 0xff_000000)
		@win_font.draw("Enter to restart!! ", 200, 500, 3.0, 1.0, 1.0, 0xff_000000)
		@win_font.draw("Escape to close!! ", 200, 550, 3.0, 1.0, 1.0, 0xff_000000)
	end

	if @round_one_not_complete == false
		@begining_of_game.draw("Round four Complete!", 100 , 450, 3.0, 1.0, 1.0, 0xff_000000)
	end

	@background_image.each do |background|
		background.draw
	end

  end
	
  def needs_cursor?
      true
  end
  
end

window = GameWindow.new.show