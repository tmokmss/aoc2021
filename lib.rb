# pad around a 2D array with val
# input matrix:
# 1 2 3
# 4 5 6 
# output pad(matrix, 0):
# 0 0 0 0 0
# 0 1 2 3 0
# 0 4 5 6 0
# 0 0 0 0 0, 3, 2
def pad!(matrix, val)
  h = matrix.size
  w = matrix[0].size
  (0...h).each do |i|
    matrix[i].unshift(val)
    matrix[i].push(val)
  end
  matrix.unshift(Array.new(w + 2, val))
  matrix.push(Array.new(w + 2, val))
  [h, w]
end

def around8(x=0, y=0)
	[[-1,-1], [-1,0], [-1,1], [0,-1], [0,1], [1,-1], [1,0], [1,1]].map {|dx,dy| [x+dx, y+dy]}
end

def around4(x=0, y=0)
	[[-1,0], [0,-1], [0,1], [1,0]].map {|dx,dy| [x+dx, y+dy]}
end