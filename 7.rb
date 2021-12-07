require "prettyprint"
require "set"

input_path = if ARGV.length < 1
  "input/7.txt"
else
  "sample/7.txt"
end

puts "Load input from #{input_path}"

input = File.read(input_path).split(",").map(&:to_i)

n = input.size

def median(array)
  return nil if array.empty?
  sorted = array.sort
  len = sorted.length
  (sorted[(len - 1) / 2] + sorted[len / 2]) / 2.0
end

p input
med = median(input)
p input.map{|a|(med-a).abs}.sum

def cost(dst, src)
  diff = (dst-src).abs
  diff * (diff + 1 )/2
end

minf = 10000000000
(input.min..input.max).each do |dst|
  newcost = input.map{|src| cost(dst,src)}.sum
  minf = newcost if newcost < minf
end

puts minf
