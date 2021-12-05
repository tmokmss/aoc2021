require "prettyprint"
require "set"

input_path = if ARGV.length < 1
  "input/5.txt"
else
  "sample/5.txt"
end

puts "Load input from #{input_path}"

input = File.read(input_path).split("\n").map(&:strip)
parsed = input.map do |line|
  match = /(.*) -> (.*)/.match(line)
  [match[1].split(',').map(&:to_i), match[2].split(',').map(&:to_i)]
end

n = input.size
covered = Hash.new(0)

parsed.each do |line|
  c1 = line[0]
  c2 = line[1]

  next if c1[0] != c2[0] and c1[1] != c2[1]

  if c1[0] == c2[0]
    ([c1[1],c2[1]].min..[c1[1],c2[1]].max).each do |i|
      covered[[c1[0], i]] += 1
    end
  end

  if c1[1] == c2[1]
    ([c1[0],c2[0]].min..[c1[0],c2[0]].max).each do |i|
      covered[[i, c1[1]]] += 1
    end
  end
end

ans = covered.filter {|k, v| v > 1}.count

puts(ans)

# part 2
covered = Hash.new(0)

parsed.each do |line|
  c1 = line[0]
  c2 = line[1]

  if c1[0] == c2[0]
    ([c1[1],c2[1]].min..[c1[1],c2[1]].max).each do |i|
      covered[[c1[0], i]] += 1
    end
    next
  end

  if c1[1] == c2[1]
    ([c1[0],c2[0]].min..[c1[0],c2[0]].max).each do |i|
      covered[[i, c1[1]]] += 1
    end
    next
  end

  # diagonal
  c1, c2 = c2, c1 if c1[0] > c2[0]
  # p [c1, c2]``
  (c1[0]..c2[0]).each_with_index do |x, i|
    y = c1[1] + ((c1[1] < c2[1] ? 1: -1) * i)
    # p [x, y]
    covered[[x, y]] += 1
  end
end

p covered

ans = covered.filter {|k, v| v > 1}.count

puts(ans)
