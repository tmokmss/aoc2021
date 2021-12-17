require "prettyprint"
require "set"
require_relative "./lib"

input_path = if ARGV.length < 1
    "input/17.txt"
  else
    "sample/17.txt"
  end

puts "Load input from #{input_path}"

input = File.read(input_path).strip
match = /target area: x=(.*)\.\.(.*), y=(.*)\.\.(.*)/.match(input)
rangex = [match[1], match[2]].map(&:to_i)
rangey = [match[3], match[4]].map(&:to_i)
p rangex, rangey

def vdiffx(curr)
  return 0 if curr == 0
  return curr + 1 if curr < 0

  curr - 1
end

def vdiffy(curr)
  curr - 1
end

def stepx(c, v)
  c += v
  v = vdiffx(v)
  [c, v]
end

def stepy(c, v)
  c += v
  v = vdiffy(v)
  [c, v]
end

def search_ymax(range)
  max = 0
  (1..100).each do |vy|
    py = 0
    maxy = 0
    loop do
      py, vy = stepy(py, vy)
      maxy = [maxy, py].max
      if py >= range[0] && py <= range[1]
        p max
        max = [maxy, max].max
        break
      end
      break if py <= range[0]
    end
  end
  max
end

p search_ymax(rangey)

def search_ykind(range)
  ans = Hash.new { |h, k| h[k] = [] }
  (-100..100).each do |vy|
    vvy = vy
    py = 0
    t = 0
    loop do
      t += 1
      py, vy = stepy(py, vy)
      ans[vvy].push(t) if py >= range[0] && py <= range[1]
      break if py <= range[0]
    end
  end
  ans
end

yans = search_ykind(rangey)

def search_xkind(range, tt)
  # find x values that can reach destination on time tt
  ans = []
  (1..300).each do |vx|
    vvx = vx
    px = 0
    t = 0
    loop do
      t += 1
      px, vx = stepx(px, vx)
      if tt.include?(t) && (px >= range[0] && px <= range[1])
        ans.push(vx)
        break
      end
      break if t > tt.max
    end
  end
  ans
end

p yans
ans = yans.map { |_k, v| search_xkind(rangex, v) }
p ans
ans = ans.map(&:size).sum
p ans
