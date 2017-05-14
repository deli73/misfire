require 'gosu'

module Z
    BACKGROUND, OBJECT = *0..1
end

module D
    N,E,S,W = *0..3
end

WIDTH, HEIGHT = 640, 480

class Game < Gosu::Window
    def initialize
        super WIDTH, HEIGHT
        self.caption = "an experiment"
        @mov = Mover.new
    end

    def update
        @mov.move(3,3)
    end

    def draw
        @mov.draw
    end

end

class Mover
    def initialize
        @x = WIDTH / 2
        @y = HEIGHT / 2
        @img = Gosu::Image.new("sprites/mover.bmp")
        @w = @img.width
        @h = @img.height
    end

    def crossing?(dir)
        if dir == D::N then
            return @y <= 0
        end
        if dir == D::S then
            return @y >= HEIGHT-@h
        end
        if dir == D::W then
            return @x <= 0
        end
        if dir == D::E then
            return @x >= WIDTH-@w
        end
    end

    def outside?
        return @x <= -(@w) || @x >= WIDTH || @y <= -(@h) || @y >= HEIGHT
    end

    def move(dx,dy)
        @x += dx
        @y += dy
        if outside? then
            @x %= WIDTH
            @y %= HEIGHT
        end
    end

    def draw
        draw_at(@x,@y) #"real" location
        if crossing? D::W then draw_at(@x+WIDTH,@y) end
        if crossing? D::E then draw_at(@x-WIDTH,@y) end
        if crossing? D::N then draw_at(@x,@y+HEIGHT) end
        if crossing? D::S then draw_at(@x,@y-HEIGHT) end
        if crossing? D::N and crossing? D::W then draw_at(@x+WIDTH,@y+HEIGHT) end
        if crossing? D::N and crossing? D::E then draw_at(@x-WIDTH,@y+HEIGHT) end
        if crossing? D::S and crossing? D::W then draw_at(@x+WIDTH,@y-HEIGHT) end
        if crossing? D::S and crossing? D::E then draw_at(@x-WIDTH,@y-HEIGHT) end
    end

    def draw_at(x,y)
        @img.draw(x, y, Z::OBJECT)
    end
end


Game.new.show