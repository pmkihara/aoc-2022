input = File.read(File.join(__dir__, './input.txt'))

class Cave
  @@all = {}
  @@max_y = 0

  attr_reader :x, :y
  attr_accessor :value

  def initialize(attrs = {})
    @x = attrs[:x]
    @y = attrs[:y]
    @value = attrs[:value]
    @@all[[@x, @y]] = self if @value == 'rock' || @value == 'sand'
    @@max_y = @y if @y > @@max_y && @value == 'rock'
  end

  def self.drop?(x_pos, y_pos)
    lower = get_lower(x_pos, y_pos)
    return false unless lower

    diagonal_left = @@all[[lower.x - 1, lower.y]]
    diagonal_right = @@all[[lower.x + 1, lower.y]]

    if diagonal_left && diagonal_right
      new({ x: lower.x, y: lower.y - 1, value: 'sand' })
      true
    elsif diagonal_left.nil?
      drop?(lower.x - 1, lower.y)
    else
      drop?(lower.x + 1, lower.y)
    end
  end

  def self.drop_with_floor(rocks)
    return false if rocks.empty?

    new_rocks = []

    rocks.each do |rock|
      left = @@all[[rock.x - 1, rock.y]]
      right = @@all[[rock.x + 1, rock.y]]
      next if left.nil? || right.nil? || rock.y + 1 > @@max_y + 2

      new_rocks << new({ x: rock.x, y: rock.y + 1, value: 'sand' })
    end

    drop_with_floor(new_rocks)
  end

  def self.all
    @@all.values
  end

  def self.max_y
    @@max_y
  end

  def self.get_lower(node_x, node_y)
    lower = @@all.select { |key, _value| key[0] == node_x && key[1] > node_y - 1 }.min { |a, b| a[0][1] <=> b[0][1] }
    lower ? lower[1] : false
  end

  def self.get_rocks_inside_triangle
    count = 0
    (@@max_y + 2).times do |i|
      count += @@all.keys.select { |coords| coords[0].between?(500 - i, 500 + i) && coords[1] == i }.length
    end
    count
  end
end

def prepare_input(input)
  input.lines.map do |line|
    line.chomp.split(' -> ')
  end
end

def create_rocks(rocks)
  rocks.each do |rock_line|
    prev_x = 0
    prev_y = 0
    rock_line.each do |rock|
      coords = rock.split(',').map(&:to_i)

      Cave.new({ x: coords[0], y: coords[1], value: 'rock' }) if prev_x.zero? && prev_y.zero?

      prev_x = coords[0] if prev_x.zero?
      prev_y = coords[1] if prev_y.zero?

      ordered_x = [prev_x, coords[0]].sort
      ordered_y = [prev_y, coords[1]].sort

      if coords[0] == prev_x
        Range.new(ordered_y[0], ordered_y[1]).each do |y|
          Cave.new({ x: coords[0], y: y, value: 'rock' }) unless y == prev_y
        end
      elsif coords[1] == prev_y
        Range.new(ordered_x[0], ordered_x[1]).each do |x|
          Cave.new({ x: x, y: coords[1], value: 'rock' }) unless x == prev_x
        end
      end

      prev_x = coords[0]
      prev_y = coords[1]
    end
  end
end

def solve1(input)
  rocks = prepare_input(input)
  create_rocks(rocks)

  keep_dropping = true
  count = -1
  while keep_dropping
    keep_dropping = Cave.drop?(500, 0)
    count += 1
  end
  count
end

def solve2(input)
  rocks = prepare_input(input)
  create_rocks(rocks)
  max_y = Cave.max_y

  count = (max_y + 2)**2

  Cave.drop_with_floor(Cave.all)

  p count
  p Cave.all.length
  p Cave.get_rocks_inside_triangle

  count - Cave.get_rocks_inside_triangle
end

# time_start = Time.now
# p solve1(input)
p solve2(input) # < 29084
# time_end = Time.now
# p time_end - time_start
