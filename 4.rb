require "set"
require 'prettyprint'

if ARGV.length < 1
  input_path = "input/4.txt"
else
  input_path = "sample/4.txt"
end

puts "Load input from #{input_path}"

input = File.read(input_path).split("\n").map(&:strip)

call = input[0].split(",").map(&:to_i)

boards = [[]]

input[2..].each do |line|
  if line == ""
    boards.push([])
    next
  end
  curr = boards[-1]
  curr.push(line.split.map(&:to_i).map{|n| [n, false]})
end

def is_bingo(board)
  n = board.size
  n1 = n-1
  # horizontal
  (0...n).each do |i|
    (0...n).each do |j|
      break unless board[i][j][1]
      return true if j == n1
    end
  end

  # vertical
  (0...n).each do |i|
    (0...n).each do |j|
      break unless board[j][i][1]
      return true if j == n1
    end
  end

  # diagonal
  # (0...n).each do |i|
  #   break unless board[i][i][1]
  #   return true if i == n1
  # end
  # (0...n).each do |i|
  #   break unless board[i][n1-i][1]
  #   return true if i == n1
  # end

  false
end

def check(board, num)
  n = board.size
  (0...n).each do |i|
    (0...n).each do |j|
      if board[j][i][0] == num
        board[j][i][1] = true
        return
      end
    end
  end
end

ans = 0

call.each do |c|
  boards.each do |b|
    check(b, c)
    if is_bingo(b)
      pp b, c
      sum = b.map{|aa| aa.filter {|a| !a[1]}.map{|a|a[0]}.sum}.sum
      ans = sum * c
      break
    end
  end
  break if ans != 0 
end

puts(ans)


# reset
boards.each do |board|
  n = board.size
  (0...n).each do |i|
    (0...n).each do |j|
      board[j][i][1] = false
    end
  end
end

done = Set.new
ans2 = 0

call.each do |c|
  boards.each_with_index do |b, i|
    check(b, c)
    if is_bingo(b)
      done.add(i)
      if done.size == boards.size
        pp b, c
        sum = b.map{|aa| aa.filter {|a| !a[1]}.map{|a|a[0]}.sum}.sum
        ans2 = sum * c
        break
      end
    end
  end
  break if ans2 != 0 
end

puts ans2