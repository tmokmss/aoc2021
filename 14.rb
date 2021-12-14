require "prettyprint"
require "set"
require_relative "./lib"

input_path = if ARGV.length < 1
    "input/14.txt"
  else
    "sample/14.txt"
  end

puts "Load input from #{input_path}"

input = File.read(input_path).split("\n").map(&:strip)
init = input[0]
rules = input[2..].map do |line|
  match = /(.*) -> (.*)/.match(line)
  [match[1], match[2]]
end.to_h


p init
p rules
n = input.size
ans = 0

input.each_with_index do |line, i|
end

(0...n).each do |i|
  input[i]
end

def apply(src, rules)
  dst = src[0]
  (1...src.size).each do |i|
    next unless rules[src[i-1..i]]
    dst += rules[src[i-1..i]] + src[i]
  end
  dst
end

ans = init
10.times do 
  ans = apply(ans, rules)
end

counts = ans.chars.uniq.map {|c| ans.count(c)}
p counts.max - counts.min

pairs = Hash.new(0)
(1...init.size).each do |i|
  pairs[init[i-1]+init[i]] += 1
end
p pairs 

def apply2(src, rules)
  dst = Hash.new(0)
  src.each do |k, v|
    rule = rules[k]
    if rule
      dst[k[0] + rule] += v
      dst[rule + k[1]] += v
    else
      dst[k] += v
    end
  end

  dst
end

ans = pairs
40.times do
  ans = apply2(ans, rules)
end

count2 = Hash.new(0)
ans.each do |k, v|
  count2[k[0]] += v
  count2[k[1]] += v
end
count2[init[0]] += 1
count2[init[-1]] += 1
count2.each do |k, v|
  count2[k] = v / 2
end
p init

p ans
p count2
p count2.values.max - count2.values.min