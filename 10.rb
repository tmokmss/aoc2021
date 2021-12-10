require "prettyprint"
require "set"

input_path = if ARGV.length < 1
  "input/10.txt"
else
  "sample/10.txt"
end

puts "Load input from #{input_path}"

input = File.read(input_path).split("\n").map(&:strip)

score = {
  ')'=>3,
  ']'=>57,
  '}'=>1197,
  '>'=>25137,
}

match = {
  '('=>')',
  '['=>']',
  '{'=>'}',
  '<'=>'>',
}

illegals = []
incomplete = []
input.each_with_index do |line, i|
  stack = []
  illegal = false
  line.chars.each do |c|
    if ['(','<','{','['].include?(c)
      stack.push(c)
    else
      cc = stack.pop
      if match[cc] != c
        illegals.push(c)
        illegal = true
      end
    end
  end
  incomplete.push (line) unless illegal
end

puts illegals.map{|c|score[c]}.sum

score2 = {
  ')'=>1,
  ']'=>2,
  '}'=>3,
  '>'=>4,
}

scores = incomplete.map do |line|
  stack = []
  line.chars.each do |c|
    if ['(','<','{','['].include?(c)
      stack.push(c)
    else
      stack.pop
    end
  end
  score = 0
  while stack.size > 0
    c = stack.pop
    score *= 5
    score += score2[match[c]]
  end
  score
end

p scores.sort[scores.size / 2]