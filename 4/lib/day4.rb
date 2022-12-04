input = File.read(File.join(__dir__, './input.txt'))

def prepare_input(input)
  input.lines.map do |line|
    line.chomp.split(',').map do |elf|
      range = elf.split ('-')
      (range[0].to_i)..(range[1].to_i)
    end
  end
end

def fully_contains?(pair)
  pair[0].cover?(pair[1]) || pair[1].cover?(pair[0])
end

def overlaps?(pair)
  (pair[0].to_a & pair[1].to_a).length.positive?
end

def solve1(input)
  pairs = prepare_input(input)
  pairs.select { |pair| fully_contains?(pair) }.length
end

def solve2(input)
  pairs = prepare_input(input)
  pairs.select { |pair| overlaps?(pair) }.length
end

# p solve1(input)
p solve2(input)
