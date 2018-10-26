require 'gosu'
require 'rubygems'
system("cls")

class GameWindow < Gosu::Window
	def initialize
	super 640, 480, false
		self.caption = "Controls "
		@win_font = Gosu::Font.new(50)
		@win_font2 = Gosu::Font.new(30)
		@win_font3 = Gosu::Font.new(10)
		@underscore = "_" * 28
		@dash = "|"
		@double_gun_power_up_image = Gosu::Image.new("double gun power up.png")
		@triple_gun_power_up_image = Gosu::Image.new("triple gun power up.png")
		@arrowKeys = Gosu::Image.new("arrow keys .png")
	end
  
	def update
		
		if button_down?(Gosu::MsLeft) and mouse_x > 390 and mouse_x < 640 and mouse_y > 425 and mouse_y < 480
			close
		end
	
		if button_down?(Gosu::KbEscape)
			close
		end
		
	end
  
	def draw
		@double_gun_power_up_image.draw(480, 225, 1)
		@triple_gun_power_up_image.draw(530, 225, 1)
		@win_font.draw("Controls: ", 230, 0, 3.0, 1.0, 1.0, 0xff_ff00ff)
		@win_font.draw("Power up collectibles: ", 0, 220, 3.0, 1.0, 1.0, 0xff_ff00ff)
		@win_font2.draw("Your ship fall from sky? it give you life. ", 0, 270, 3.0, 1.0, 1.0, 0xff_ff00ff)
		@win_font3.draw("If you can read this, press 'j'", 0, 260, 3.0, 1.0, 1.0, 0xff_ff00ff)
		#@win_font.draw("#{mouse_x} #{mouse_y}", 0, 0, 3.0, 1.0 , 1.0, 0xff_ff00ff)
		@win_font.draw("#{@underscore}: ", 0, 0, 3.0, 1.0, 1.0, 0xff_ff00ff)
		@win_font.draw("Move: ", 0, 100, 3.0, 1.0, 1.0, 0xff_ff00ff)
		@win_font.draw("Shoot: ", 0, 300, 3.0, 1.0, 1.0, 0xff_ff00ff)
		@win_font.draw("Spacebar ", 210, 300, 3.0, 1.0, 1.0, 0xff_ff00ff)
		@win_font.draw("Play Game ", 410, 430, 3.0, 1.0, 1.0, 0xff_ff00ff)
		@win_font.draw("Click to: ", 210, 430, 3.0, 1.0, 1.0, 0xff_ff00ff)
		@win_font.draw("#{@underscore} ", 400, 380, 3.0, 1.0, 1.0, 0xff_ff00ff)
		@win_font.draw("|", 392, 416, 3.0, 1.0, 1.0, 0xff_ff00ff)
		@win_font.draw("|", 392, 420, 3.0, 1.0, 1.0, 0xff_ff00ff)
		@win_font.draw("|", 392, 440, 3.0, 1.0, 1.0, 0xff_ff00ff)
		@arrowKeys.draw(250, 100, 2)
	end
	
	def needs_cursor?
		true
	end
end

GameWindow.new.show