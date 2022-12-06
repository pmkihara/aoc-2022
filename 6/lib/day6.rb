input = File.read(File.join(__dir__, './input.txt'))

def solve1(input)
  input = input.chomp

  start_index = 0
  end_index = 3
  until input[start_index..end_index].chars.uniq.length == 4
    start_index += 1
    end_index += 1
  end
  end_index + 1
end

def solve2(input)
  input = input.chomp

  start_index = 0
  end_index = 13
  until input[start_index..end_index].chars.uniq.length == 14
    start_index += 1
    end_index += 1
  end
  end_index + 1
end

# p solve1(input)
p solve2(input)
