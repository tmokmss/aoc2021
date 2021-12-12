require "prettyprint"
require "set"
require_relative "./lib"

input_path = if ARGV.length < 1
    "input/12.txt"
  else
    "sample/12.txt"
  end

puts "Load input from #{input_path}"

input = File.read(input_path).split("\n").map(&:strip)
parsed = input.map do |line|
  match = /(.*)\-(.*)/.match(line)
  [match[1], match[2]]
end

graph = Hash.new { |h, k| h[k] = Set.new }
parsed.each do |src, dst|
  graph[src].add(dst)
  graph[dst].add(src)
end

p graph

def small?(c)
  return c == c.downcase
end

def search_path(graph, current, seen)
  return 1 if current == "end"

  routes = graph[current]
  count = 0
  routes.each do |route|
    next if small?(route) && seen.member?(route)
    seen.add(route)
    count += search_path(graph, route, seen)
    seen.delete(route)
  end

  return count
end

puts search_path(graph, "start", Set.new(["start"]))

def search_path2(graph, current, seen, twice_used)
  return 1 if current == "end"

  routes = graph[current]
  count = 0
  routes.each do |route|
    next if route == "start"
    if small?(route) && seen.member?(route)
      if twice_used
        next
      else
        count += search_path2(graph, route, seen, true)
        next
      end
    end
    seen.add(route)
    count += search_path2(graph, route, seen, twice_used)
    seen.delete(route)
  end

  return count
end

puts search_path2(graph, "start", Set.new(["start"]), false)
