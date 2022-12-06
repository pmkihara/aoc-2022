require_relative '../lib/day5'
example = File.read(File.join(__dir__, '../lib/example.txt'))

describe '#separate_crates' do
  it 'should separate the one-line crates correctly' do
    expect(separate_crates(['    [D]    ', ' 1   2   3'])).to eq ([[], ['D'], []])
    expect(separate_crates(['[N] [C]    ', ' 1   2   3'])).to eq ([['N'], ['C'], []])
    expect(separate_crates(['[Z] [M] [P]', ' 1   2   3'])).to eq ([['Z'], ['M'], ['P']])
  end

  it 'should separate multiple line crates correctly' do
    expect(separate_crates(['    [D]    ', '[N] [C]    ', '[Z] [M] [P]', ' 1   2   3 '])).to eq ([['Z', 'N'], ['M', 'C', 'D'], ['P']])
  end
end

describe '#separate_instructions' do
  it 'should separate the instructions correctly' do
    expect(separate_instructions(['move 1 from 2 to 1'])).to eq ([{n_crates: 1, start_point: 2, end_point: 1}])
    expect(separate_instructions(['move 1 from 2 to 1', 'move 3 from 1 to 3'])).to eq ([{n_crates: 1, start_point: 2, end_point: 1}, {n_crates: 3, start_point: 1, end_point: 3}])
  end
end

describe '#prepare_input' do
  let(:crates) { prepare_input(example)[:crates] }
  let(:instructions) { prepare_input(example)[:instructions] }

  it 'should separate the crates in an array' do
    expect(crates).to be_a Array
    expect(crates.size).to eq 3
  end

  it 'should separate the instructions in an array' do
    expect(instructions).to be_a Array
    expect(instructions.size).to eq 4
    expect(instructions).to eq [
      {n_crates: 1, start_point: 2, end_point: 1},
      {n_crates: 3, start_point: 1, end_point: 3},
      {n_crates: 2, start_point: 2, end_point: 1},
      {n_crates: 1, start_point: 1, end_point: 2},
    ]
  end
end


describe '#move_crates' do
  it 'should return an Array with the crates' do
    expect(move_crates([['Z', 'N'], ['M', 'C', 'D'], ['P']], {n_crates: 1, start_point: 2, end_point: 1})).to be_a Array
    expect(move_crates([['Z', 'N'], ['M', 'C', 'D'], ['P']], {n_crates: 1, start_point: 2, end_point: 1}).size).to eq 3
  end

  it 'should return the correct position of the crates' do
    expect(move_crates([['Z', 'N'], ['M', 'C', 'D'], ['P']], {n_crates: 1, start_point: 2, end_point: 1})).to eq [['Z', 'N', 'D'], ['M', 'C'], ['P']]
    expect(move_crates([['Z', 'N', 'D'], ['M', 'C'], ['P']], {n_crates: 3, start_point: 1, end_point: 3})).to eq [[], ['M', 'C'], ['P', 'D', 'N', 'Z']]
    expect(move_crates([[], ['M', 'C'], ['P', 'D', 'N', 'Z']], {n_crates: 2, start_point: 2, end_point: 1})).to eq [['C', 'M'], [], ['P', 'D', 'N', 'Z']]
    expect(move_crates([['C', 'M'], [], ['P', 'D', 'N', 'Z']], {n_crates: 1, start_point: 1, end_point: 2})).to eq [['C'], ['M'], ['P', 'D', 'N', 'Z']]
  end
end

describe '#move_multiple_crates' do
  it 'should return an Array with the crates' do
    expect(move_multiple_crates([['Z', 'N'], ['M', 'C', 'D'], ['P']], {n_crates: 1, start_point: 2, end_point: 1})).to be_a Array
    expect(move_multiple_crates([['Z', 'N'], ['M', 'C', 'D'], ['P']], {n_crates: 1, start_point: 2, end_point: 1}).size).to eq 3
  end

  it 'should return the correct position of the crates' do
    expect(move_multiple_crates([['Z', 'N'], ['M', 'C', 'D'], ['P']], {n_crates: 1, start_point: 2, end_point: 1})).to eq [['Z', 'N', 'D'], ['M', 'C'], ['P']]
    expect(move_multiple_crates([['Z', 'N', 'D'], ['M', 'C'], ['P']], {n_crates: 3, start_point: 1, end_point: 3})).to eq [[], ['M', 'C'], ['P', 'Z', 'N', 'D']]
    expect(move_multiple_crates([[], ['M', 'C'], ['P', 'Z', 'N', 'D']], {n_crates: 2, start_point: 2, end_point: 1})).to eq [['M', 'C'], [], ['P', 'Z', 'N', 'D']]
    expect(move_multiple_crates([['M', 'C'], [], ['P', 'Z', 'N', 'D']], {n_crates: 1, start_point: 1, end_point: 2})).to eq [['M'], ['C'], ['P', 'Z', 'N', 'D']]
  end
end

describe '#solve1' do
  it 'should return the correct value' do
    expect(solve1(example)).to eq 'CMZ'
  end
end

describe '#solve2' do
  it 'should return the correct value' do
    expect(solve2(example)).to eq 'MCD'
  end
end
