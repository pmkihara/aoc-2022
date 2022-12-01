input = File.read('input.txt')
example = File.read('example.txt')

def sort_by_elf(input)
  input.split("\n\n").map { |group| group.split("\n").map(&:to_i) }
end

def solve1(input)
  sort_by_elf(input).map(&:sum).max
end

def solve2(input)
  sort_by_elf(input).map(&:sum).max(3).sum
end

p solve2(input)
