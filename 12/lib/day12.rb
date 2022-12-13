input = File.read(File.join(__dir__, './input.txt'))

class Node
  @@all = {}
  @@start_node = 0
  @@end_node = 0

  attr_reader :value, :x, :y
  attr_accessor :parent, :distance, :visited

  def initialize(attrs = {})
    @value = attrs[:value]
    @next = @value == 'z' ? 'z' : @value.next
    @x = attrs[:x]
    @y = attrs[:y]
    @distance = Float::INFINITY
    @parent = false
    @visited = false
    @@start_node = self if attrs[:start_node]
    @@end_node = self if attrs[:end_node]
    @@all[[@x, @y]] = self
  end

  def visit!
    @visited = true
  end

  def neighbours
    neighbours = []

    right = @@all[[@x + 1, @y]]
    neighbours << right if right && right.value <= @next

    left = @@all[[@x - 1, @y]]
    neighbours << left if left && left.value <= @next

    top = @@all[[@x, @y - 1]]
    neighbours << top if top && top.value <= @next

    bottom = @@all[[@x, @y + 1]]
    neighbours << bottom if bottom && bottom.value <= @next

    neighbours
  end

  def self.all
    @@all.values
  end

  def self.start_node
    @@start_node
  end

  def self.end_node
    @@end_node
  end

  def self.visited_nodes
    all.select(&:visited)
  end

  def self.reset_all!
    all.each do |node|
      node.distance = Float::INFINITY
      node.parent = false
      node.visited = false
    end
  end
end

def create_nodes(input)
  input.lines.each_with_index do |line, line_index|
    line.chomp!.chars.each_with_index do |char, char_index|
      elevation = case char
                  when 'S' then 'a'
                  when 'E' then 'z'
                  else char
                  end
      Node.new({ value: elevation, x: char_index, y: line_index, end_node: char == 'E', start_node: char == 'S' })
    end
  end
end

def bfs(destination, queue)
  return if queue.empty?

  current = queue.shift

  current.neighbours.each do |neighbour|
    neighbour.visit!
    if neighbour.distance > current.distance + 1
      neighbour.parent = current
      neighbour.distance = current.distance + 1
      queue.push(neighbour)
    end
  end
  bfs(destination, queue)
end

def trace_route(destination, route)
  node = route.last
  return route.reverse if node == destination
  return [] unless node.parent

  route << node.parent

  trace_route(destination, route)
end

def solve1(input)
  create_nodes(input)
  start_node = Node.start_node
  end_node = Node.end_node
  start_node.visit!
  start_node.distance = 0
  queue = Queue.new
  queue << start_node
  bfs(end_node, queue)
  route = trace_route(start_node, [end_node])
  # Node.all.each do |n|
  #   puts "[#{n.x}. #{n.y}] = #{n.value} / #{n.distance}"
  # end
  route.length - 1
end

def solve2(input)
  create_nodes(input)
  start_nodes = Node.all.select { |n| n.value == 'a' }
  end_node = Node.end_node
  possibilities = []
  start_nodes.each do |start_node|
    start_node.visit!
    start_node.distance = 0
    queue = Queue.new
    queue << start_node
    bfs(end_node, queue)
    route = trace_route(start_node, [end_node])
    possibilities << route.length - 1 unless route.empty?
    Node.reset_all!
  end
  possibilities.min
end

# p solve1(input)
p solve2(input)
