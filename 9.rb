require 'prettyprint'
require 'set'

input_path = if ARGV.length < 1
               'input/9.txt'
             else
               'sample/9.txt'
             end

puts "Load input from #{input_path}"

input = File.read(input_path).split("\n").map(&:strip)
cave = input.map { |i| [9].concat(i.chars.map(&:to_i)).concat([9]) }
h = input.size
w = input[0].size
cave.push(Array.new(w + 2, 9))
cave = [Array.new(w + 2, 9)].concat(cave)

ans = 0

(1..h).each do |i|
  (1..w).each do |j|
    now = cave[i][j]
    danger = true
    [[1, 0], [-1, 0], [0, 1], [0, -1]].each do |di, dj|
      danger &= now < cave[i + di][j + dj]
    end
    ans += now + 1 if danger
  end
end

puts(ans)

basins = []
seen = Set.new

def search_basin(i, j, seen, basin, cave)
  now = cave[i][j]
  return if now == 9
  return if seen.member?([i, j])

  basin.add([i, j])
  seen.add([i, j])

  [[1, 0], [-1, 0], [0, 1], [0, -1]].each do |di, dj|
    search_basin(i + di, j + dj, seen, basin, cave)
  end
end

(1..h).each do |i|
  (1..w).each do |j|
    next if seen.member?([i, j])

    basin = Set.new
    search_basin(i, j, seen, basin, cave)
    basins.push(basin) if basin.size > 0
  end
end


puts basins.sort_by { |b| -b.size }[0..2].map { |b| b.size }.inject(:*)
