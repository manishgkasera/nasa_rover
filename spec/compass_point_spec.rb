require 'spec_helper'
require 'compass_point'

describe 'CompassPoint' do
  valid_faces = [:N, :E, :S, :W]

  it 'should always have one face and should always be on of NEWS' do
    c = CompassPoint.new
    c.face.nil?.should be(false)
    valid_faces.include?(c.face).should be(true)

    c = CompassPoint.new(:S)
    c.face.should eq(:S)
    valid_faces.include?(c.face).should be(true)
  end

  it 'should move to left correctly' do
    c = CompassPoint.new(:N)
    c.face.should eq :N
    c.move_to_left
    c.face.should eq :W
    c.move_to_left
    c.face.should eq :S
    c.move_to_left
    c.face.should eq :E
    c.move_to_left
    c.face.should eq :N
  end

  it 'should move to right correctly' do
    c = CompassPoint.new(:N)
    c.face.should eq :N
    c.move_to_right
    c.face.should eq :E
    c.move_to_right
    c.face.should eq :S
    c.move_to_right
    c.face.should eq :W
    c.move_to_right
    c.face.should eq :N
  end
end