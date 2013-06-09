require_relative 'compass_point'

#Rover represents a rover on a plateau,
#it has a position which are valid coordinates on a plateau plus a compass direction
class Rover
  attr_reader :plateau, :pos_x, :pos_y, :compass_point

  def initialize(plateau, pos_x=0, pos_y=0, face=:N)
    if plateau.coordinate_blank?(pos_x, pos_y)
      @plateau, @pos_x, @pos_y, @compass_point = plateau, pos_x, pos_y, CompassPoint.new(face)
    else
      raise "Cannot add rover to position X:#{x}, Y:#{y} on plateau: #{plateau}"
    end
  end


  def move(directions)
    old_position = self.position
    directions.each_char do |direction|
      case direction
      when 'L'
        compass_point.move_to_left
      when 'R'
        compass_point.move_to_right
      when 'M'
        begin
          case compass_point.face
          when :N
            move_to_coordinate(@pos_x, @pos_y+1)
          when :E
            move_to_coordinate(@pos_x+1, @pos_y)
          when :S
            move_to_coordinate(@pos_x, @pos_y-1)
          when :W
            move_to_coordinate(@pos_x-1, @pos_y)
          end
        rescue CannotMove
          restore_position(old_position)
          raise
        end
      else
        raise "Invalid Move command #{direction}, should be one of L,R,M"
      end
    end
  end

  def position
    "#{pos_x} #{pos_y} #{compass_point.face}"
  end
  alias inspect position
  alias to_s inspect

  class CannotMove < StandardError; end

  private
    def move_to_coordinate(x, y)
      if plateau.coordinate_blank?(x, y)
        @pos_x, @pos_y = x, y
      else
        raise CannotMove
      end
    end

    def restore_position(old_position)
      pos = old_position.split(' ')
      @compass_point = CompassPoint.new(pos.pop.to_sym)
      @pos_x, @pos_y = pos.map(&:to_i)
    end

end