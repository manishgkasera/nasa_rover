require 'spec_helper'
require 'plateau'

describe 'Plateau' do
  it 'should raise invalid coordinates error on initialize if the same are not valid' do
    invalid_coordinates = [
      [1,2,1,3],
      [1,2,0,3],
      [1,2,-1,3],
      [1,2,3,2],
      [1,2,3,1],
      [1,2,3,1]
    ]
    invalid_coordinates.each do |co|
      begin
        Plateau.new(*co)
        #should not reach here
        1.should eq(2), "Expected to raise invalid arguments for #{co}"
      rescue Plateau::InvalidCoordinates
      end
    end
  end

  it 'should except valid coordinates' do
    valid_coordinates = [1,2,3,4]
    begin
      Plateau.new(*valid_coordinates)
    rescue InvalidCoordinates
      #should not come here
      1.should eq(2), "Raised InvalidCoordinates error for valid coordinates: #{valid_coordinates}"
    end
  end
  it 'should say true for asking a valid coordinates presence in it'
  it 'should say false for asking a coordinates outside of it'
end