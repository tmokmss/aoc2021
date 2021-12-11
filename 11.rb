require "prettyprint"
require "set"

input_path = if ARGV.length < 1
  "input/11.txt"
else
  "sample/11.txt"
end

puts "Load input from #{input_path}"

input = File.read(input_path).split("\n").map(&:strip)
octopuses = input.map{|i|i.chars.map(&:to_i)}

def pad!(matrix, val)
  h = matrix.size
  w = matrix[0].size
  (0...h).each do |i|
    matrix[i].unshift(val)
    matrix[i].push(val)
  end
  matrix.unshift(Array.new(w + 2, val))
  matrix.push(Array.new(w + 2, val))
  matrix
end

pad!(octopuses, -2)

ans = 0
(0...100).each do |_|
  first = true
  loop do
    old_ans = ans
    (1..10).each do |i|
      (1..10).each do |j|
        oct = first ? (octopuses[i][j] += 1) : octopuses[i][j]
        if oct > 9
          ans += 1
          (-1..1).each do |di|
            (-1..1).each do |dj|
              next if di == 0 && dj == 0
              next if octopuses[i+di][j+dj] < 0
              octopuses[i+di][j+dj] += 1
            end
          end
          octopuses[i][j] = -1
        end
      end
    end
    break if old_ans == ans
    first = false
  end
  (1..10).each do |i|
    (1..10).each do |j|
      octopuses[i][j] = 0 if octopuses[i][j] == -1
    end
  end
end

puts(ans)

input = File.read(input_path).split("\n").map(&:strip)
octopuses = input.map{|i|i.chars.map(&:to_i)}
pad!(octopuses, -2)

ans2 = 1
loop do
  ans = 0
  first = true
  loop do
    old_ans = ans
    (1..10).each do |i|
      (1..10).each do |j|
        oct = first ? (octopuses[i][j] += 1) : octopuses[i][j]
        if oct > 9
          ans += 1
          (-1..1).each do |di|
            (-1..1).each do |dj|
              next if di == 0 && dj == 0
              next if octopuses[i+di][j+dj] < 0
              octopuses[i+di][j+dj] += 1
            end
          end
          octopuses[i][j] = -1
        end
      end
    end
    break if old_ans == ans
    first = false
  end
  (1..10).each do |i|
    (1..10).each do |j|
      octopuses[i][j] = 0 if octopuses[i][j] == -1
    end
  end
  break if ans == 100
  ans2 += 1
end

p ans2