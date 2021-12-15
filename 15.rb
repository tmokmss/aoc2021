require 'prettyprint'
require 'set'
require_relative './lib'

input_path = if ARGV.length < 1
               'input/15.txt'
             else
               'sample/15.txt'
             end

puts "Load input from #{input_path}"

input = File.read(input_path).split("\n").map(&:strip)
cave = input.map { |line| line.chars.map(&:to_i) }

INF = 1_000_000_000
dp = Hash.new(INF)
h, w = pad!(cave, INF)

goal = [w, h]
dp[goal] = cave[h][w]

queue = [goal]
until queue.empty?
  now = queue.shift
  curr = dp[now]
  around4(now[0], now[1]).each do |x, y|
    if dp[[x, y]] > curr + cave[y][x]
      dp[[x, y]] = curr + cave[y][x]
      queue.push([x, y])
    end
  end
end

puts dp[[1, 1]] - cave[1][1]

input = File.read(input_path).split("\n").map(&:strip)
cave = input.map { |line| line.chars.map(&:to_i) }

cave2 = array2d(w * 5, h * 5)
(0...h).each do |y|
  (0..4).each do |yi|
    yy = y + yi * h
    (0...w).each do |x|
      (0..4).each do |xi|
        xx = x + xi * h
        risk = (cave[y][x] + yi + xi) % 9
        risk = 9 if risk == 0
        cave2[yy][xx] = risk
      end
    end
  end
end

dp = Hash.new(INF)
h, w = pad!(cave2, INF)

goal = [w, h]
dp[goal] = cave2[h][w]

queue = [goal]
until queue.empty?
  now = queue.shift
  curr = dp[now]
  around4(now[0], now[1]).each do |x, y|
    if dp[[x, y]] > curr + cave2[y][x]
      dp[[x, y]] = curr + cave2[y][x]
      queue.push([x, y])
    end
  end
end

puts dp[[1, 1]] - cave2[1][1]
