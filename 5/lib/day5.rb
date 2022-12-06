input = File.read(File.join(__dir__, './input.txt'))

def separate_crates(array)
  n_crates = array.pop.strip[-1].to_i
  regex = ' ?(   |\[\w\])' * n_crates
  grid = array.map do |line|
    match_data = line.match(Regexp.new(regex))
    crates = []
    n_crates.times do |i|
      crates << match_data[i + 1][1]
    end
    crates
  end
  grid.reverse.transpose.map {|col| col.reject { |item| item == ' ' } }
end

def separate_instructions(array)
  array.map do |line|
    match_data = line.match(/move (\d+) from (\d+) to (\d+)/)
    {
      n_crates: match_data[1].to_i,
      start_point: match_data[2].to_i,
      end_point: match_data[3].to_i
    }
  end
end

def prepare_input(input)
  split = input.split("\n\n").map { |string| string.split("\n") }
  {
    crates: separate_crates(split[0]),
    instructions: separate_instructions(split[1])
  }
end

def move_crates(crates, instruction)
  start_column = crates[instruction[:start_point] - 1]
  end_column = crates[instruction[:end_point] - 1]
  moved_crates = start_column.pop(instruction[:n_crates]).reverse
  end_column.push(moved_crates)
  end_column.flatten!
  crates
end

def move_multiple_crates(crates, instruction)
  start_column = crates[instruction[:start_point] - 1]
  end_column = crates[instruction[:end_point] - 1]
  moved_crates = start_column.pop(instruction[:n_crates])
  end_column.push(moved_crates)
  end_column.flatten!
  crates
end

def solve1(input)
  prepared_input = prepare_input(input)
  crates = prepared_input[:crates]
  prepared_input[:instructions].each do |instruction|
    crates = move_crates(crates, instruction)
  end
  crates.map(&:last).join
end

def solve2(input)
  prepared_input = prepare_input(input)
  crates = prepared_input[:crates]
  prepared_input[:instructions].each do |instruction|
    crates = move_multiple_crates(crates, instruction)
  end
  crates.map(&:last).join
end

# p solve1(input)
p solve2(input)
