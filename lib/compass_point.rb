class CompassPoint
  attr_reader :face
  alias inspect face
  alias to_s inspect

  FACES = [:N, :E, :S, :W]

  def initialize(face = :N)
    if FACES.include?(face)
      @face = face
    else
      raise InvalidFace
    end
  end

  def move_to_left
    @face = FACES[(FACES.index(face) - 1)]
  end

  def move_to_right
    i = FACES.index(face)
    i = i == (FACES.size - 1) ? 0 : i+1
    @face = FACES[i]
  end

  class InvalidFace < StandardError
  end
end