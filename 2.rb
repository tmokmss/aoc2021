require "set"

if ARGV.length < 1
  input_path = "input/2.txt"
else
  input_path = "sample/2.txt"
end

puts "Load input from #{input_path}"

input = File.read(input_path).split("\n").map(&:strip)
parsed = input.map do |line|
  match = /(.*)\s(.*)/.match(line)
  [match[1], match[2].to_i]
end

n = input.size
ans = 0

x = 0
y = 0 

parsed.each do |dir, val|
  x += val if dir == 'forward'
  y -= val if dir == 'up'
  y += val if dir == 'down'
end
p (x*y)


x = 0
y = 0 
aim = 0

parsed.each do |dir, val|
  x += val if dir == 'forward'
  y += val * aim if dir == 'forward'
  aim -= val if dir == 'up'
  aim += val if dir == 'down'
end

p x*y
