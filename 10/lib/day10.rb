input = File.read(File.join(__dir__, './input.txt'))

def map_cycles(input)
  x = 1
  cycle = 1
  signal_strengths = {}

  input.lines.each do |line|
    line.chomp!
    signal_strengths[cycle] = x
    cycle += 1

    next if line.start_with?('noop')

    signal_strengths[cycle] = x
    cycle += 1
    x += line.split[1].to_i
  end
  signal_strengths
end

def signal_strengths(input)
  cycles = map_cycles(input)
  {
    20 => cycles[20],
    60 => cycles[60],
    100 => cycles[100],
    140 => cycles[140],
    180 => cycles[180],
    220 => cycles[220]
  }
end

def draw_lines(input)
  cycles = map_cycles(input)
  cycle_count = 1

  Array.new(6).map do |_map|
    line = []

    40.times do |index|
      x_position = [cycles[cycle_count], cycles[cycle_count] + 1, cycles[cycle_count] + 2]
      line << (x_position.include?(index + 1) ? '#' : '.')
      cycle_count += 1
    end
    line.join
  end
end

def solve1(input)
  signal_strengths = signal_strengths(input)
  signal_strengths.reduce(0) { |sum, (cycle, x)| sum + (cycle * x) }
end

def solve2(input)
  draw_lines(input).each do |line|
    puts line
  end
end

# p solve1(input)
solve2(input)
