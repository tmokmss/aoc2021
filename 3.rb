require "set"

if ARGV.length < 1
  input_path = "input/3.txt"
else
  input_path = "sample/3.txt"
end

puts "Load input from #{input_path}"

input = File.read(input_path).split("\n").map(&:strip)

n = input.size
bits = input[0].size
ans = 0

count = Hash.new {|h,k| h[k] = {'0' => 0, '1' => 0}}

input.each_with_index do |line, i|
  line.chars.each_with_index do |c, j|
    count[j][c] += 1
  end
end

gamma = ""
epsilon = ""
(0...bits).each do |i|
  ci = count[i]
  if ci['0'] > ci['1']
    gamma += '0'
    epsilon += '1'
  else 
    gamma += '1'
    epsilon += '0'
  end
end

p gamma, epsilon

gamma = gamma.to_i(2)
epsilon = epsilon.to_i(2)

puts(gamma*epsilon)

o2s=(0...n)
(0...bits).each do |i|
  zero = 0
  one = 0
  ones = []
  zeros = []
  o2s.each do |j|
    ones.push(j) if input[j][i] == '1'
    zeros.push(j) if input[j][i] == '0'
  end
  if ones.size >= zeros.size
    o2s = ones
  else
    o2s = zeros
  end
  break if o2s.size == 1
end
o2 = input[o2s[0]]

co2s=(0...n)
(0...bits).each do |i|
  zero = 0
  one = 0
  ones = []
  zeros = []
  co2s.each do |j|
    ones.push(j) if input[j][i] == '1'
    zeros.push(j) if input[j][i] == '0'
  end
  if (zeros.size <= ones.size and zeros.size > 0) or ones.size == 0
    co2s = zeros
  else
    co2s = ones
  end
  break if co2s.size == 1
end
co2 = input[co2s[0]]

p o2, co2
co2 = co2.to_i(2)
o2 = o2.to_i(2)

puts(co2*o2)
