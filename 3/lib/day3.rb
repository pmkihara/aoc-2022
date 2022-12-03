input = File.read(File.join(__dir__, './input.txt'))

LETTER_VALUES = {
  'a' => 1,
  'b' => 2,
  'c' => 3,
  'd' => 4,
  'e' => 5,
  'f' => 6,
  'g' => 7,
  'h' => 8,
  'i' => 9,
  'j' => 10,
  'k' => 11,
  'l' => 12,
  'm' => 13,
  'n' => 14,
  'o' => 15,
  'p' => 16,
  'q' => 17,
  'r' => 18,
  's' => 19,
  't' => 20,
  'u' => 21,
  'v' => 22,
  'w' => 23,
  'x' => 24,
  'y' => 25,
  'z' => 26,
  'A' => 1 + 26,
  'B' => 2 + 26,
  'C' => 3 + 26,
  'D' => 4 + 26,
  'E' => 5 + 26,
  'F' => 6 + 26,
  'G' => 7 + 26,
  'H' => 8 + 26,
  'I' => 9 + 26,
  'J' => 10 + 26,
  'K' => 11 + 26,
  'L' => 12 + 26,
  'M' => 13 + 26,
  'N' => 14 + 26,
  'O' => 15 + 26,
  'P' => 16 + 26,
  'Q' => 17 + 26,
  'R' => 18 + 26,
  'S' => 19 + 26,
  'T' => 20 + 26,
  'U' => 21 + 26,
  'V' => 22 + 26,
  'W' => 23 + 26,
  'X' => 24 + 26,
  'Y' => 25 + 26,
  'Z' => 26 + 26,
}

def prepare_input(input)
  input.lines.map(&:chomp)
end

def split_line_in_half(line)
  line.chars.each_slice(line.length / 2).to_a
end

def find_repeated_letter(line)
  rucksack = split_line_in_half(line)
  (rucksack[0] & rucksack [1])[0]
end

def split_in_groups_of_three(lines)
  lines.each_slice(3).to_a
end

def find_common_letter_in_group(group)
  group_chars = group.map(&:chars)
  (group_chars[0] & group_chars[1] & group_chars[2])[0]
end

def solve1(input)
  rucksacks = prepare_input(input)
  rucksacks.reduce(0) do |sum, rucksack|
    item = find_repeated_letter(rucksack)
    sum + LETTER_VALUES[item]
  end
end

def solve2(input)
  rucksacks = prepare_input(input)
  groups = split_in_groups_of_three(rucksacks)
  groups.reduce(0) do |sum, group|
    item = find_common_letter_in_group(group)
    sum + LETTER_VALUES[item]
  end
end

# p solve1(input)
p solve2(input)
