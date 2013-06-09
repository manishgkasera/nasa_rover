require 'spec_helper'
require 'plateau'
require 'rover'

describe 'Rover' do
  it 'should tell its position right' do
    p = Plateau.new(0,0,10,10)
    r = Rover.new(p, 5,5,:N)
    r.position.should eq('5 5 N')
  end

  it 'should move to right on "R"' do
    p = Plateau.new(0,0,10,10)
    r = Rover.new(p, 5,5,:N)
    r.move('R')
    r.position.should eq('5 5 E')
    r.move('R')
    r.position.should eq('5 5 S')
    r.move('R')
    r.position.should eq('5 5 W')
    r.move('R')
    r.position.should eq('5 5 N')
  end

  it 'should move to left on "L"' do
    p = Plateau.new(0,0,10,10)
    r = Rover.new(p, 5,5,:N)
    r.move('L')
    r.position.should eq('5 5 W')
    r.move('L')
    r.position.should eq('5 5 S')
    r.move('L')
    r.position.should eq('5 5 E')
    r.move('L')
    r.position.should eq('5 5 N')
  end

  it 'should go ahead on "M"' do
    p = Plateau.new(0,0,10,10)
    r = Rover.new(p, 5,5,:N)
    r.move('M')
    r.position.should eq('5 6 N')
    r.move('MR')
    r.position.should eq('5 7 E')
    r.move('MR')
    r.position.should eq('6 7 S')
    r.move('ML')
    r.position.should eq('6 6 E')
  end

  it 'should raise exception when moving to invalid coordinate' do
    p = Plateau.new(0,0,5,5)
    r = Rover.new(p, 5,5,:N)

    ['M', 'MR', 'RM'].each do |command|
      begin
        r.move(command)
        1.should eq(2), "Rover should not be moved on plateau #{p} with position #{r.position} on #{command} command"
      rescue Rover::CannotMove
      end
    end
  end

  it 'should raise exception when initializing with invalid coordinates' do
    p = Plateau.new(0,0,5,5)
    begin
      Rover.new(p, 5,6,:N)
      1.should eq(2), "Rover should not be initialized if added to non existing location on plateau"
    rescue
    end
  end

  it 'should raise exception when initializing with coordinates where there is already a rover' do
    p = PlateauWithRovers.new(0,0,5,5)
    Rover.new(p, 5,5,:N)
    begin
      Rover.new(p, 5,5,:N)
      1.should eq(2), "Rover should not be initialized if added to location which is not blank"
    rescue
    end
  end
end