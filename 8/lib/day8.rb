input = File.read(File.join(__dir__, './input.txt'))

class Tree
  @@visible_tree_count = 0
  @@max_scenic_score = 0

  attr_accessor :top_neighbours, :bottom_neighbours, :left_neighbours, :right_neighbours

  def initialize(attrs = {})
    @height = attrs[:height]
    @edge = attrs[:edge] || false
    @top_neighbours = []
    @bottom_neighbours = []
    @left_neighbours = []
    @right_neighbours = []
  end

  def visible?
    if @edge ||
       @height > @top_neighbours.max ||
       @height > @bottom_neighbours.max ||
       @height > @left_neighbours.max ||
       @height > @right_neighbours.max
      @@visible_tree_count += 1
      return true
    end
    false
  end

  def calculate_scenic_score
    top_tallest_index = @top_neighbours.find_index { |neighbour| neighbour >= @height }
    top_score = top_tallest_index ? top_tallest_index + 1 : @top_neighbours.length

    bottom_tallest_index = @bottom_neighbours.find_index { |neighbour| neighbour >= @height }
    bottom_score = bottom_tallest_index ? bottom_tallest_index + 1 : @bottom_neighbours.length

    left_tallest_index = @left_neighbours.find_index { |neighbour| neighbour >= @height }
    left_score = left_tallest_index ? left_tallest_index + 1 : @left_neighbours.length

    right_tallest_index = @right_neighbours.find_index { |neighbour| neighbour >= @height }
    right_score = right_tallest_index ? right_tallest_index + 1 : @right_neighbours.length

    scenic_score = top_score * bottom_score * left_score * right_score
    @@max_scenic_score = scenic_score if scenic_score > @@max_scenic_score
  end

  def self.visible_tree_count
    @@visible_tree_count
  end

  def self.max_scenic_score
    @@max_scenic_score
  end
end

def prepare_input(input)
  input.lines.map { |line| line.chomp.chars.map(&:to_i) }
end

def create_forest(lines)
  cols = lines.transpose
  lines.each_with_index do |line, line_index|
    line.each_with_index do |char, char_index|
      tree = Tree.new({
                        height: char,
                        edge: (line_index.zero? ||
                               char_index.zero? ||
                               line_index == lines.length - 1 ||
                               char_index == line.length - 1)
                      })
      tree.top_neighbours = cols[char_index][0...line_index].reverse
      tree.bottom_neighbours = cols[char_index][(line_index + 1)..]
      tree.left_neighbours = line[0...char_index].reverse
      tree.right_neighbours = line[(char_index + 1)..]
      tree.visible?
      tree.calculate_scenic_score
    end
  end
end

def solve1(input)
  lines = prepare_input(input)
  create_forest(lines)
  Tree.visible_tree_count
end

def solve2(input)
  lines = prepare_input(input)
  create_forest(lines)
  Tree.max_scenic_score
end

# p solve1(input)
p solve2(input)
