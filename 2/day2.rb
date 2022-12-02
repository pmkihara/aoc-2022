input = File.read('input.txt')
example = File.read('example.txt')

def prepare_input(input)
  input.lines.map { |line| line.chomp.split }
end

SHAPES1 = {
  # rock
  'X' => {
    'A' => 3,
    'B' => 0,
    'C' => 6,
    score: 1
  },
  # paper
  'Y' => {
    'A' => 6,
    'B' => 3,
    'C' => 0,
    score: 2
  },
  # scissors
  'Z' => {
    'A' => 0,
    'B' => 6,
    'C' => 3,
    score: 3
  },
}

SHAPES2 = {
  # lose
  'X' => {
    'A' => 3, # rock wins to scissors
    'B' => 1, # paper wins to rock
    'C' => 2, # scissors wins to paper

  },
  # draw
  'Y' => {
    'A' => 1 + 3, # rock
    'B' => 2 + 3, # paper
    'C' => 3 + 3, # scissors
  },
  # win
  'Z' => {
    'A' => 2 + 6, # rock loses to paper
    'B' => 3 + 6, # paper loses to scissors
    'C' => 1 + 6, # scissors lose to rock
  },
}

def solve1(input)
  prepare_input(input).reduce(0) do |sum, play|
    shape = SHAPES1[play[1]]
    sum + shape[play[0]] + shape[:score]
  end

end

def solve2(input)
  prepare_input(input).reduce(0) do |sum, play|
    shape = SHAPES2[play[1]]
    sum + shape[play[0]]
  end

end

p solve2(input)
