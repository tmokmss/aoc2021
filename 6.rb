require 'prettyprint'
require 'set'

input_path = if ARGV.length < 1
               'input/6.txt'
             else
               'sample/6.txt'
             end

puts "Load input from #{input_path}"

input = File.read(input_path).split(',').map(&:strip).map(&:to_i)

n = input.size

class Fish
  attr_accessor :timer

  def initialize(timer = nil)
    @timer = timer || 8
  end

  def pass
    @timer -= 1
    born = timer == -1
    @timer = 6 if timer == -1
    born
  end
end

fish = input.map { |i| Fish.new(i) }

(0...80).each do |_day|
  newfish = []
  fish.each do |f|
    born = f.pass
    newfish.push(Fish.new) if born
  end
  fish.concat(newfish)
end

puts fish.size

fish_group = Hash.new(0)
input.each { |i| fish_group[i] += 1 }
(0...256).each do |_day|
  new_fish_group = Hash.new(0)
  fish_group.each do |timer, num|
    if timer == 0
      new_fish_group[6] += num
      new_fish_group[8] += num
    else
      new_fish_group[timer - 1] += num
    end
  end
  fish_group = new_fish_group
end

puts fish_group.values.sum
