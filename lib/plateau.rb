class Plateau
  attr_reader   :start_x, :start_y, :end_x, :end_y

  def initialize(sx, sy, ex, ey)
    if coordinates_valid?(sx, sy, ex, ey)
      @start_x, @start_y, @end_x, @end_y = sx, sy, ex, ey
    else
      raise InvalidCoordinates.new(@errors.join("\n"))
    end
  end

  private
    def coordinates_valid?(sx, sy, ex, ey)
      add_error 'Difference between start x cordinate and end x cordinate should atleast be one' if ex - sx < 1
      add_error 'Difference between start y cordinate and end y cordinate should atleast be one' if ey - sy < 1
      @errors.nil?
    end

    def add_error(msg)
      if @errors && @errors.any?
        @errors << msg
      else
        @errors = [msg]
      end
    end

  public
  class InvalidCoordinates < StandardError
  end
end