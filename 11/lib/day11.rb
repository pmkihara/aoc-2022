input = File.read(File.join(__dir__, './input.txt'))

class Monkey
  @@all = {}
  @@mod = 1 # least common denominator

  attr_reader :inspect_count, :monkey_number, :denominator
  attr_accessor :items

  def initialize(attrs = {})
    @monkey_number = attrs[:monkey_number]
    @items = attrs[:starting_items]
    @operation = attrs[:operation]
    @denominator = attrs[:denominator]
    @true_monkey = attrs[:true_monkey]
    @false_monkey = attrs[:false_monkey]
    @inspect_count = 0
    @@all[@monkey_number] = self
    @@mod *= @denominator
  end

  def inspect_items!
    until @items.empty? do
      old = @items.shift
      worry_level = eval(@operation) / 3
      next_monkey = (worry_level % @denominator).zero? ? @@all[@true_monkey] : @@all[@false_monkey]
      next_monkey.items << worry_level
      @inspect_count += 1
    end
  end

  def inspect_items_without_relief!
    until @items.empty? do
      old = @items.shift
      worry_level = eval(@operation) % @@mod
      next_monkey = (worry_level % @denominator).zero? ? @@all[@true_monkey] : @@all[@false_monkey]
      next_monkey.items << worry_level
      @inspect_count += 1
    end
  end

  def self.all
    @@all.values
  end

  def self.visit_all_monkeys
    all.each(&:inspect_items!)
  end

  def self.visit_all_monkeys_part2
    all.each(&:inspect_items_without_relief!)
  end
end

def create_monkeys(input)
  input.split("\n\n").each do |monkey_text|
    monkey_lines = monkey_text.lines.map(&:chomp)
    monkey_info = {
      monkey_number: monkey_lines[0][7...-1].to_i,
      starting_items: monkey_lines[1].scan(/\d+/).map(&:to_i),
      operation: monkey_lines[2].split(': ')[1],
      denominator: monkey_lines[3].scan(/\d+/)[0].to_i,
      true_monkey: monkey_lines[4].scan(/\d+/)[0].to_i,
      false_monkey: monkey_lines[5].scan(/\d+/)[0].to_i,
    }
    Monkey.new(monkey_info)
  end
  Monkey.all
end

def solve1(input)
  create_monkeys(input)
  20.times do
    Monkey.visit_all_monkeys
  end
  top_two = Monkey.all.max(2) {|a, b| a.inspect_count <=> b.inspect_count }
  top_two[0].inspect_count * top_two[1].inspect_count
end

def solve2(input)
  create_monkeys(input)
  10_000.times do
    Monkey.visit_all_monkeys_part2
  end
  top_two = Monkey.all.max(2) {|a, b| a.inspect_count <=> b.inspect_count }
  top_two[0].inspect_count * top_two[1].inspect_count
end

# p solve1(input)
# p solve2(input)
