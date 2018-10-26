system("gem install gosu")

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
require './double_gun_power up.rb'
require './triple_gun_power up.rb'
require './controlls menu.rb'

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
		@are_double_guns_activated = false
		@are_triple_guns_activated = false
		@userAmmo = 500

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
        @song = Gosu::Song.new("star.mp3")
        @song.play(true)
		@explosion = Gosu::Sample.new("explosion.wav")
		@shoot = Gosu::Sample.new("shoot.wav")
		@player_ship = Ship.new
		@player_ship_two = Ship.new
		@player_ship_three = Ship.new
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
		x = rand(1..749)
		y = 0
		@player_double_guns = DoubleGunPowerUp.new(self, x, y)
		@player_triple_guns = TripleGunPowerUp.new(self, x, y)
		@timer_five = Time.new
		@enemy_ship_bomb_array = []
		@timer_four = Time.new
		@timer_many = Time.new
		@ship_move_right = true
		@ship_move_left = false
		@enemy_ship_move_left = false
		@player_wipe_screen = false
		@counter_twenty = 0
		@timer_fifty = Time.new
		@score_copy = @score
		@player_wipe_screen_not_used = false
		@bullet_array2 = []
		@bullet_array3 = []
		@counter50 = 0
		@counter60 = 0
		@player_health_power_up = Ship.new
		@player_health_power_up_not_applyed = false
		@player_health_power_up.x = 380
		@player_health_power_up.y = -50
		@counter_counter = 0
		@dev_cheet_code = false
		@distance_from_player = 0
    end

    def are_touching?(obj1, obj2)
        obj1.x > obj2.x - obj1.width and obj1.x < obj2.x + obj2.width and obj1.y > obj2.y - obj1.height and obj1.y < obj2.y + obj2.height
    end

    def update

		if @score == 200
			@double_gun_power_up_chance = true
		end

		if Gosu::button_down?(Gosu::KbU)
		  @userAmmo = 100000000
		end

		if @score == 10
			@player_wipe_screen = true
		end

		if @score == 100
			@player_health_power_up_not_applyed = true
		end

		if @score == 300
			@player_health_power_up_not_applyed = true
			@player_health_power_up = Ship.new
			@player_health_power_up.x = 380
			@player_health_power_up.y = -50
			@counter_counter = 0
		end

		if @score == 600
			@player_health_power_up_not_applyed = true
			@player_health_power_up = Ship.new
			@player_health_power_up.x = 380
			@player_health_power_up.y = -50
			@counter_counter = 0
		end

		if @score == 800
			@player_health_power_up_not_applyed = true
			@player_health_power_up = Ship.new
			@player_health_power_up.x = 380
			@player_health_power_up.y = -50
			@counter_counter = 0
		end

		if @score == 500
			@triple_gun_power_up_chance = true
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

		if @score >= 1000
			@round_one_not_complete = false
		end


		if are_touching?(@player_double_guns, @player_ship)
			@player_double_guns.y = 5000
			@double_guns = true
		end


		if are_touching?(@player_triple_guns, @player_ship)
			@player_triple_guns.y = 5000
			@triple_guns = true
		end

	    if Gosu::button_down?(Gosu::KbEscape)
	        close
	    end

		if button_down?(Gosu::KbJ)
			@dev_cheet_code = true
		end

		if button_down?(Gosu::KbK) and @dev_cheet_code == true
			@dev_cheet_code = false
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
		
		if button_down?(Gosu::KbEnter) && @round_one_not_complete == false
			@badguy = []
			@bullet_array = []
			@rocket_array = []
			@background_image = []
			@islandone = []
			@islandtwo = []
			@are_double_guns_activated = false
			@are_triple_guns_activated = false
			@userAmmo = 500

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
			@song = Gosu::Song.new("star.mp3")
			@song.play(true)
			@explosion = Gosu::Sample.new("explosion.wav")
			@shoot = Gosu::Sample.new("shoot.wav")
			@player_ship = Ship.new
			@player_ship_two = Ship.new
			@player_ship_three = Ship.new
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
			x = rand(1..749)
			y = 0
			@player_double_guns = DoubleGunPowerUp.new(self, x, y)
			@player_triple_guns = TripleGunPowerUp.new(self, x, y)
			@timer_five = Time.new
			@enemy_ship_bomb_array = []
			@timer_four = Time.new
			@timer_many = Time.new
			@ship_move_right = true
			@ship_move_left = false
			@enemy_ship_move_left = false
			@player_wipe_screen = false
			@counter_twenty = 0
			@timer_fifty = Time.new
			@score_copy = @score
			@player_wipe_screen_not_used = false
			@bullet_array2 = []
			@bullet_array3 = []
			@counter50 = 0
			@counter60 = 0
			@player_health_power_up = Ship.new
			@player_health_power_up_not_applyed = false
			@player_health_power_up.x = 380
			@player_health_power_up.y = -50
			@counter_counter = 0
			@dev_cheet_code = false
			@distance_from_player = 0
		end


		@badguy.each do |enemyship|
			if enemyship.y > 0 and enemyship.y < 1080 and Time.new - @timer_three > 0.5
				@enemy_ship_bullet_array.push(FireBall.new(self, enemyship.x + 30, enemyship.y))
	           	@timer_three = Time.new
			end
		end

		if are_touching?(@player_ship, @player_health_power_up) and @counter_counter <= 1
			@player_lives_counter += 1
			@counter_counter += 1
			@player_health_power_up.y = 5000
		end

	        if Gosu::button_down?(Gosu::KbSpace) and Time.new - @timer > 0.1 and @player_ship_is_dead == false && @userAmmo != 0
	            if @double_guns != true and @rocket_power_up != true
			    	@bullet_array.push(FireBall.new(self, @player_ship.x + 24, @player_ship.y))
            @userAmmo -= 1
					if @dev_cheet_code == true && @userAmmo != 0
						@bullet_array2.push(FireBall.new(self, @player_ship_two.x + 24, @player_ship_two.y))
						@bullet_array3.push(FireBall.new(self, @player_ship_three.x + 24, @player_ship_three.y))
            @userAmmo -= 1
					end
					@timer = Time.new
				end
				if @double_guns == true and Gosu::button_down?(Gosu::KbSpace) and Time.new - @timer > 0.1 and @triple_guns != true and @rocket_power_up != true && @userAmmo != 0
					@bullet_array.push(FireBall.new(self, @player_ship.x + 12, @player_ship.y))
					@bullet_array.push(FireBall.new(self, @player_ship.x + 36, @player_ship.y))
          @userAmmo -= 1
					if @dev_cheet_code == true && @userAmmo != 0
						@bullet_array2.push(FireBall.new(self, @player_ship_two.x + 12, @player_ship_two.y))
						@bullet_array3.push(FireBall.new(self, @player_ship_three.x + 12, @player_ship_three.y))
						@bullet_array2.push(FireBall.new(self, @player_ship_two.x + 36, @player_ship_two.y))
						@bullet_array3.push(FireBall.new(self, @player_ship_three.x + 36, @player_ship_three.y))
            @userAmmo -= 1
					end
					@timer = Time.new
				end

				if @triple_guns == true and Gosu::button_down?(Gosu::KbSpace) and Time.new - @timer > 0.1 and @rocket_power_up != true && @userAmmo != 0
					@bullet_array.push(FireBall.new(self, @player_ship.x + 0, @player_ship.y))
					@bullet_array.push(FireBall.new(self, @player_ship.x + 24, @player_ship.y))
					@bullet_array.push(FireBall.new(self, @player_ship.x + 48, @player_ship.y))
          @userAmmo -= 1
					if @dev_cheet_code == true && @userAmmo != 0
						@bullet_array2.push(FireBall.new(self, @player_ship_two.x + 0, @player_ship_two.y))
						@bullet_array3.push(FireBall.new(self, @player_ship_three.x + 0, @player_ship_three.y))
						@bullet_array2.push(FireBall.new(self, @player_ship_two.x + 24, @player_ship_two.y))
						@bullet_array3.push(FireBall.new(self, @player_ship_three.x + 24, @player_ship_three.y))
						@bullet_array2.push(FireBall.new(self, @player_ship_two.x + 48, @player_ship_two.y))
						@bullet_array3.push(FireBall.new(self, @player_ship_three.x + 48, @player_ship_three.y))
            @userAmmo -= 1
					end
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
					@rand = rand(0..1)
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
						@explosion.play
						@rand = rand(0..1)
						@score += 10
						@explosion_array.push(Explosion.new(enemyship.x - 20, enemyship.y - 20))
					end
					if @counter >= 3
						@counter = 0
					end
					@bullet_array.delete(fireball)
					@bullet_array2.delete(fireball)
					@bullet_array3.delete(fireball)
                end
            end
        end

		if @player_ship_two.x <= 0
			@player_ship_two.x = 0
		end

		if @player_ship_three.x >= 730
			@player_ship_three.x = 730
		end

		@bullet_array2.each do |fireball|
        fireball.shoot
            @badguy.each do |enemyship|
                if are_touching?(fireball, enemyship)
					@counter50 += 1
					if @counter50 >= 3
						@badguy.delete(enemyship)
						@explosion.play
						@rand = rand(0..1)
						@score += 10
						@explosion_array.push(Explosion.new(enemyship.x - 20, enemyship.y - 20))
					end
					if @counter50 >= 3
						@counter50 = 0
					end
					@bullet_array.delete(fireball)
					@bullet_array2.delete(fireball)
					@bullet_array3.delete(fireball)
                end
            end
        end

		@bullet_array3.each do |fireball|
        fireball.shoot
            @badguy.each do |enemyship|
                if are_touching?(fireball, enemyship)
					@counter60 += 1
					if @counter60 >= 3
						@badguy.delete(enemyship)
						@explosion.play
						@rand = rand(0..1)
						@score += 10
						@explosion_array.push(Explosion.new(enemyship.x - 20, enemyship.y - 20))
					end
					if @counter60 >= 3
						@counter60 = 0
					end
					@bullet_array.delete(fireball)
					@bullet_array2.delete(fireball)
					@bullet_array3.delete(fireball)
                end
            end
        end

	    @badguy.each do |enemyship|
            if are_touching?(enemyship, @player_ship) and @respawn != true and Time.new - @timer_five > 5
				@player_ship_is_dead = true
				if @player_lives_only_take_one_life == false
					@player_lives_counter -= 1
					@explosion.play
					@player_lives_only_take_one_life = true
				end
            end
        end

		@bullet_array.each do |fireball|
		    if fireball.y < 0
		        @bullet_array.delete(fireball)
		    end
		end

		@bullet_array2.each do |fireball|
		    if fireball.y < 0
		        @bullet_array2.delete(fireball)
		    end
		end

		@bullet_array3.each do |fireball|
		    if fireball.y < 0
		        @bullet_array3.delete(fireball)
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
			enemyship.move
			enemyship.bounce
=begin
			if @player_wipe_screen == true and button_down?(Gosu::KbM) and @player_wipe_screen_not_used == false
				counter = 0
				if enemyship.y > -50
					@badguy.delete(enemyship)
					@explosion_array.push(Explosion.new(enemyship.x - 20, enemyship.y - 20))
					@score += 10
					counter += 1
				end

				if counter == 5
					@player_wipe_screen_not_used = true
				end
			end
=end
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

		if @double_gun_power_up_chance == true
			@player_double_guns.y += 5
		end

		if @triple_gun_power_up_chance == true
			@player_triple_guns.y += 5
		end

		if @player_health_power_up_not_applyed == true
			@player_health_power_up.y += 5
		end



    end

  def draw
	if @player_lives_counter != 0 and @player_lives_counter_two <= 120 and @round_one_not_complete == true and @round_one_not_complete == true

		if Time.new - @timer_two < 5
			@begining_of_game.draw("Round one: Destroy 100 Ships! ", 0, 350, 3.0, 1.0, 1.0, 0xff_000000)
		end

		@win_font.draw("Score: #{@score} ", 0, 1000, 3.0, 1.0, 1.0, 0xff_ff00ff)
    @win_font.draw("Ammo: #{@userAmmo} ", 500, 0, 3.0, 1.0, 1.0, 0xff_ff00ff)
		@win_font.draw("High Score: #{@highscore} ", 0 , 0, 3.0, 1.0, 1.0, 0xff_ff00ff)
		@win_font.draw("#{@player_lives_counter} X", 700 , 900, 3.0, 1.0, 1.0, 0xff_ff00ff)

		#if @player_wipe_screen == true
		#	@win_font.draw("Press 'M' for screen wipe", 0 , 450, 3.0, 1.0, 1.0, 0xff_ff00ff)
		#end

		if @counter_two <= 20 and @counter_three <= 4
			@player_ship.draw
		end

		if @counter_three > 4
			@player_ship.draw
		end

		if @player_health_power_up_not_applyed == true
			@player_health_power_up.draw
		end

		if @dev_cheet_code == true
			@player_ship_two.draw
			@player_ship_two.x = @player_ship.x - 75
			@player_ship_two.y = @player_ship.y

			@player_ship_three.draw
			@player_ship_three.x = @player_ship.x + 75
			@player_ship_three.y = @player_ship.y
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

		if @double_gun_power_up_chance == true
			@player_double_guns.draw
		end

		if @triple_gun_power_up_chance == true
			@player_triple_guns.draw
		end

		@badguy.each do |enemyship|
			enemyship.draw
		end

		@bullet_array.each do |rocket|
			rocket.draw
		end

		@bullet_array2.each do |fireball|
			fireball.draw
		end

		@bullet_array3.each do |fireball|
			fireball.draw
		end

		@enemy_ship_bullet_array.each do |fireball|
			fireball.draw
		end

		@enemy_ship_bomb_array.each do |fireball|
			fireball.draw
		end
	end

	if @player_lives_counter == 0 and @round_one_not_complete == true
		@win_font.draw("You Have lost!! ", 200, 450, 3.0, 1.0, 1.0, 0xff_000000)
		@win_font.draw("Enter to restart!! ", 200, 500, 3.0, 1.0, 1.0, 0xff_000000)
		@win_font.draw("Escape to close!! ", 200, 550, 3.0, 1.0, 1.0, 0xff_000000)
	end

	if @round_one_not_complete == false
		@begining_of_game.draw("Round One Complete!", 100 , 450, 3.0, 1.0, 1.0, 0xff_000000)
		@begining_of_game.draw("More Comming Soon!", 100 , 500, 3.0, 1.0, 1.0, 0xff_000000)
		@begining_of_game.draw("Your Score Was 1000", 100 , 550, 3.0, 1.0, 1.0, 0xff_000000)
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
