require 'spec_helper'
require 'plateau_with_rovers'

describe 'PlateauWithRovers' do
  it 'should add a rover to it self and after add rover should know about plateu' do
    p = PlateauWithRovers.new(0,0,5,5)
    rover = p.add_rover(5, 5)
    rover.plateau.should eq(p)
    p.rovers.include?(rover).should be(true)
  end

  it 'should not add a rover to it self if coordinates are not valid' do
    p = PlateauWithRovers.new(0,0,5,5)
    invalid_coordinates = [
      [-1,0],
      [0,-1],
      [-1,-1],
      [6,6],
      [6,5],
      [5,6]
    ]
    invalid_coordinates.each do |co|
      begin
        rover = p.add_rover(*co)
        1.should eq(2), "Plateau should not allow rover to be added at a non existing location: #{co}"
      rescue Plateau::InvalidCoordinates
      end
    end
  end

  it 'should not add a rover to it self if coordinates are not empty' do
    p = PlateauWithRovers.new(0,0,5,5)
    rover = p.add_rover(5, 5)
    begin
      rover = p.add_rover(5, 5)
      1.should eq(2), "Plateau should not allow rover to be added at a location where there is already a rover"
    rescue Plateau::InvalidCoordinates
    end

  end
end
