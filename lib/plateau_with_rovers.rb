require_relative 'plateau'
require_relative 'rover'

#PlateauWithRovers represents a plateau that can have one or more rovers on it
class PlateauWithRovers < Plateau
  attr_reader :rovers

  def add_rover(x=@start_x, y=@start_y, face=:N)
    if coordinate_blank?(x,y)
      rover = Rover.new(self, x, y, face)
      if @rovers
        @rovers << rover
      else
        @rovers = [rover]
      end
      return rover
    else
      raise InvalidCoordinates, @errors.join("\n")
    end
  end

  def coordinate_blank?(x, y)
    if super(x, y)
      if has_rover_on?(x, y)
        add_error("Plateau coordinates X:#{x}, Y#{y} are not blank.")
        return false
      else
        return true
      end
    else
      return false
    end
  end

  def has_rover_on?(x, y)
    rovers && rovers.any? do |rover|
      rover.pos_x == x && rover.pos_y == y
    end
  end

end