input = File.read(File.join(__dir__, './input.txt'))

def create_grid(input)
  grid = {}

  lines = input.lines
  lines.each_with_index do |line, line_index|
    line.chomp!.chars.each_with_index do |char, char_index|
      elevation = case char
                  when 'S' then 'a'
                  when 'E' then 'z'
                  else
                    char
                  end
      grid[[char_index, line_index]] = {
        coords: [char_index, line_index],
        elevation: elevation,
        neighbours: [],
        end_node: char == 'E'
      }
      grid[[char_index, line_index]][:neighbours] << [char_index - 1, line_index] if char_index >= 1
      grid[[char_index, line_index]][:neighbours] << [char_index + 1, line_index] if char_index < line.length - 1
      grid[[char_index, line_index]][:neighbours] << [char_index, line_index - 1] if line_index >= 1
      grid[[char_index, line_index]][:neighbours] << [char_index, line_index + 1] if line_index < lines.length - 1
    end
  end

  grid
end

def visit_grid(grid, queue = [])
  return grid if queue.empty?

  node_coords = queue.shift
  node = grid[node_coords]

  node[:neighbours].each do |neighbour_coords|
    neighbour = grid[neighbour_coords]
    if !neighbour[:parent] && (node_coords == [0, 0] || neighbour[:elevation] <= node[:elevation].next || node[:elevation] == 'z')
      grid[neighbour_coords][:parent] = node_coords
      queue << neighbour_coords
    end
  end

  visit_grid(grid, queue)
end

def trace_route(visited_nodes, route)
  node = route.last
  parent_node = visited_nodes[node[:parent]]
  route << parent_node

  return route if parent_node[:coords] == [0, 0]

  trace_route(visited_nodes, route)
end

def solve1(input)
  grid = create_grid(input)
  grid[[0, 0]][:parent] = 'start'
  visited_nodes = visit_grid(grid, [[0, 0]])
  end_node = visited_nodes.find { |_k, node| node[:end_node] }[1]
  route = trace_route(visited_nodes, [end_node])
  puts route.length
end

p solve1(input)
