input = File.read('input.txt').lines.map { |line| line.chomp.to_i }
example = File.read('example.txt').lines.map { |line| line.chomp.to_i }

def sort_fruits(input)
  fruits = []
  index = 0

  input.each do |num|
    if num.zero?
      index += 1
    elsif fruits[index]
      fruits[index] << num
    else
      fruits << [num]
    end
  end
  fruits
end

def solve1(input)
  fruits_by_elf = sort_fruits(input)
  fruits_by_elf.map(&:sum).max
end

def solve2(input)
  fruits_by_elf = sort_fruits(input)
  fruits_by_elf.map(&:sum).max(3).sum
end

p solve2(input)
