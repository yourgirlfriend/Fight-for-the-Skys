class FireBall
    
    attr_reader :x, :y, :width, :height
    attr_accessor :x, :y
    
    def initialize(the_window, x_position, y_position) 
        @x_position = x_position
	    @y_position = y_position
	    @y = @y_position
	    @x = @x_position + 10
	    @width = 32
	    @height = 32
	    @image = Gosu::Image.new(the_window, "fireball1.png")
        @angle = 0
    end
  
    def draw
        @image.draw_rot(@x, @y, 10, @angle) 
    end
  
    def shoot
        @y -= 10
    end

    def enemyshoot
        @y += 10
        @angle = 180
    end

    def moveBulletOffScreenWithOutKillingEnemyShip
        @x += 1000
    end
  
end