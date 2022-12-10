require 'matrix'
require 'set'
input = File.read(File.join(__dir__, './input.txt'))

class Rope
  def initialize(attrs = {})
    @size = attrs[:size]
    @knots = Array.new(@size) { { x: 0, y: 0 } }
    @tail_tracks = Set.new
    @tail_tracks << @knots[@size - 1]
  end

  def move(direction, n_steps)
    n_steps.times do
      move_head(direction)
      (@size - 1).times do |index|
        move_knot(index + 1)
      end
      # print_matrix
    end
  end

  def tail_tracks_count
    @tail_tracks.length
  end

  private

  def move_head(direction)
    case direction
    when 'U' then @knots[0][:y] += 1
    when 'D' then @knots[0][:y] -= 1
    when 'R' then @knots[0][:x] += 1
    when 'L' then @knots[0][:x] -= 1
    end
  end

  def move_knot(index)
    previous = @knots[index - 1]

    x_distance = previous[:x] - @knots[index][:x]
    y_distance = previous[:y] - @knots[index][:y]

    return if x_distance.abs <= 1 && y_distance.abs <= 1

    length = (x_distance.abs + y_distance.abs).to_f

    @knots[index] = {
      x: previous[:x] - (x_distance / length).round,
      y: previous[:y] - (y_distance / length).round
    }

    @tail_tracks << @knots[@size - 1]
  end

  def print_matrix
    m = Matrix.build(46, 62) { '.' }
    m.to_a.each_with_index do |line, line_index|
      line.each_with_index do |col, col_index|
        if col_index == 61
          puts @knots.any? { |knot| knot[:x] == col_index - 20 && knot[:y] == line_index - 10 } ? 'T' : col
        else
          print @knots.any? { |knot| knot[:x] == col_index - 20 && knot[:y] == line_index - 10 } ? 'T' : col
        end
      end
    end
    sleep(0.3)
    system 'clear'
  end
end

def solve1(input)
  rope = Rope.new({ size: 2 })

  input.lines.each do |line|
    steps = line.chomp.split
    rope.move(steps[0], steps[1].to_i)
  end

  rope.tail_tracks_count
end

def solve2(input)
  rope = Rope.new({ size: 10 })

  input.lines.each do |line|
    steps = line.chomp.split
    rope.move(steps[0], steps[1].to_i)
  end

  rope.tail_tracks_count
end

# p solve1(input)
p solve2(input)
