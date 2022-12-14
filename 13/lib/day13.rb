require 'json'
input = File.read(File.join(__dir__, './input.txt'))

def prepare_input(input)
  input.split("\n\n").map do |line|
    line.split("\n").map do |value|
      JSON.parse(value)
    end
  end
end

def right_order?(packet1, packet2)
  left, *rem_pack1 = packet1
  right, *rem_pack2 = packet2

  # Integers
  if left.instance_of?(Integer) && right.instance_of?(Integer)
    return true if left < right
    return false if left > right

    right_order?(rem_pack1, rem_pack2)

  # Arrays
  elsif left.instance_of?(Array) && right.instance_of?(Array)
    is_valid = right_order?(left, right)
    is_valid.nil? ? right_order?(rem_pack1, rem_pack2) : is_valid

  # Mixed
  elsif left.instance_of?(Integer) && right.instance_of?(Array)
    right_order?([[left], *rem_pack1], packet2)

  elsif left.instance_of?(Array) && right.instance_of?(Integer)
    right_order?(packet1, [[right], *rem_pack2])

  # Empty arrays
  elsif left.nil? && right.nil?
    nil

  elsif left.nil?
    true

  elsif right.nil?
    false
  end
end

def solve1(input)
  pairs = prepare_input(input)
  sum = 0

  pairs.each_with_index do |pair, index|
    (sum += index + 1) if right_order?(pair[0], pair[1])
  end
  sum
end

def solve2(input)
  pairs = prepare_input(input)
  packets = pairs.flatten(1) + [[[2]], [[6]]]
  sorted = packets.sort { |a, b| right_order?(a, b) ? -1 : 1 }
  index1 = sorted.find_index([[2]]) + 1
  index2 = sorted.find_index([[6]]) + 1
  index1 * index2
end

# p solve1(input)
# p solve2(input)
