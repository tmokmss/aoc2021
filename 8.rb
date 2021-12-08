require "prettyprint"
require "set"

input_path = if ARGV.length < 1
  "input/8.txt"
else
  "sample/8.txt"
end

puts "Load input from #{input_path}"

input = File.read(input_path).split("\n").map(&:strip)
pattern = []
output = []
input.each do |line|
  pat, out = line.split('|')
  pattern.push(pat.split) 
  output.push(out.split)
end

p pattern 
p output


def match_1(target, pattern)
  return target.size == pattern.size
end

ans = 0

output.each do |o|
  o.each do |num|
    if match_1(num, "fdgacbe") ||
      match_1(num, "gcbe") ||
      match_1(num, "cgb") ||
      match_1(num, "gc")
      ans += 1
    end
  end
end

puts(ans)

def match(target)
  target = target.map(&:to_i).sort!
  return '0' if target == [1,2,3,5,6,7]
  return '1' if target == [3,7]
  return '2' if target == [1,3,4,5,6]
  return '3' if target == [1,3,4,6,7]
  return '4' if target == [2,3,4,7]
  return '5' if target == [1,2,4,6,7]
  return '6' if target == [1,2,4,5,6,7]
  return '7' if target == [1,3,7]
  return '8' if target == [1,2,3,4,5,6,7]
  return '9' if target == [1,2,3,4,6,7]
  p "not found #{target}"
end

def decode(pattern, output)
#   1111  
#  2    3 
#  2    3 
#   4444  
#  5    7 
#  5    7 
#   6666 
  cand = Hash.new {|h,k| h[k] = Set.new([1,2,3,4,5,6,7])}
  c5 = Set.new('abcdefg'.chars)
  c6 = Set.new('abcdefg'.chars)
  pattern.each do |p|
    if p.size == 7
      # 8
      p.chars.each do |c|
        cand[c] = cand[c] & Set.new([1,2,3,4,5,6,7])
      end
    elsif p.size == 4
      # 4
      p.chars.each do |c|
        cand[c] = cand[c] & Set.new([2,3,4,7])
      end
    elsif p.size == 3
      # 7
      p.chars.each do |c|
        cand[c] = cand[c] & Set.new([1,3,7])
      end
    elsif p.size == 2
      # 1
      p.chars.each do |c|
        cand[c] = cand[c] & Set.new([3,7])
      end
    elsif p.size == 5
      # 2,3,5
      c5 = c5 & Set.new(p.chars)
    elsif p.size == 6
      # 0,6,9
      c6 = c6 & Set.new(p.chars)
    end
  end

  c5.each do |c|
    cand[c] = cand[c] & Set.new([1,4,6])
  end

  c6.each do |c|
    cand[c] = cand[c] & Set.new([1,2,4,6,7])
  end

  decoded = {}
  loop do
    cand.each do |k, v|
      if v.size == 1
        decoded[k] = v.first
        cand.each do |sk, sv|
          next if sk == k
          sv.subtract(v)
          if sv.size == 1
            decoded[sk] = sv.first
          end
        end
      end
    end
    break if cand.all? {|k,v| v.size == 1}
  end

  p decoded
  num = output.map do |out|
    tar = out.chars.map {|o| decoded[o].to_s}
    match(tar)
  end

  return num.inject(:+).to_i
end

ans = 0
pattern.each_with_index do |pat, i|
  out = output[i]
  ans += decode(pat, out)
end

p ans
