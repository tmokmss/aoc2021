require "prettyprint"
require "set"
require_relative "./lib"

input_path = if ARGV.length < 1
    "input/11.txt"
  else
    "sample/11.txt"
  end

puts "Load input from #{input_path}"

input = File.read(input_path).split("\n").map(&:strip)
octopuses = input.map { |i| i.chars.map(&:to_i) }

h, w = pad!(octopuses, -2)

ans = 0
(0...100).each do |_|
  first = true
  loop do
    old_ans = ans
    (1..h).each do |i|
      (1..w).each do |j|
        oct = first ? (octopuses[i][j] += 1) : octopuses[i][j]
        if oct > 9
          ans += 1
          around8(i, j).each do |ii, jj|
            next if octopuses[ii][jj] < 0
            octopuses[ii][jj] += 1
          end
          octopuses[i][j] = -1
        end
      end
    end
    break if old_ans == ans
    first = false
  end
  (1..h).each do |i|
    (1..w).each do |j|
      octopuses[i][j] = 0 if octopuses[i][j] == -1
    end
  end
end

puts(ans)

input = File.read(input_path).split("\n").map(&:strip)
octopuses = input.map { |i| i.chars.map(&:to_i) }
pad!(octopuses, -2)

ans2 = 1
loop do
  ans = 0
  first = true
  loop do
    old_ans = ans
    (1..h).each do |i|
      (1..w).each do |j|
        oct = first ? (octopuses[i][j] += 1) : octopuses[i][j]
        if oct > 9
          ans += 1
          around8(i, j).each do |ii, jj|
            next if octopuses[ii][jj] < 0
            octopuses[ii][jj] += 1
          end
          octopuses[i][j] = -1
        end
      end
    end
    break if old_ans == ans
    first = false
  end
  (1..h).each do |i|
    (1..w).each do |j|
      octopuses[i][j] = 0 if octopuses[i][j] == -1
    end
  end
  break if ans == 100
  ans2 += 1
end

p ans2
