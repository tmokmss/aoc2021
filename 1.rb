require "set"

if ARGV.length < 1
  input_path = "input/1.txt"
else
  input_path = "sample/1.txt"
end

puts "Load input from #{input_path}"

input = File.read(input_path).split("\n").map(&:strip).map(&:to_i)

n = input.size
ans = 0

last = input[0]
input[1..].each_with_index do |line, i|
  if last < line
    ans += 1
  end
  last = line
end

puts(ans)

ans2 = 0
last = input[0] + input[1] + input[2]
input[3..].each_with_index do |num, i|
  sum = last - input[i] + num
  if last < sum
    ans2 += 1
  end
  last = sum
end

puts(ans2)