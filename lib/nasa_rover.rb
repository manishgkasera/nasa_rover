#!/usr/bin/env ruby
#main program

require File.expand_path(File.join(File.dirname(__FILE__), 'plateau_with_rovers.rb'))

p = PlateauWithRovers.new(0, 0, *gets.split(' ').map(&:to_i))

while(rover_position = gets.chomp) do
  break if rover_position == ""
  rover_position = rover_position.split(' ')
  face = rover_position.pop
  moves = gets.chomp
  break if moves == ""
  p.add_rover(*rover_position.map(&:to_i), face.to_sym).move(moves)
end

p.rovers.each do |rover|
  puts rover.position
end
