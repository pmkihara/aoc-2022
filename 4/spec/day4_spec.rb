require_relative '../lib/day4'
example = File.read(File.join(__dir__, '../lib/example.txt'))

describe '#prepare_input' do
  let(:formated_example) { prepare_input(example) }
  let(:first_pair) { formated_example[0] }
  let(:second_pair) { formated_example[1] }
  let(:third_pair) { formated_example[2] }

  it 'should separate lines in an array' do
    expect(formated_example).to be_a Array
    expect(formated_example.size).to eq 6
  end

  it 'should separate the pairs of each line' do
    expect(first_pair).to be_a Array
    expect(first_pair.size).to eq 2
    expect(second_pair).to be_a Array
    expect(second_pair.size).to eq 2
    expect(third_pair).to be_a Array
    expect(third_pair.size).to eq 2
  end

  it 'should separate the section start and the section end' do
    expect(first_pair[0]).to be_a Range
    expect(first_pair[0]).to eq 2..4
    expect(second_pair[0]).to eq 2..3
    expect(second_pair[1]).to eq 4..5
    expect(third_pair[0]).to eq 5..7
    expect(third_pair[1]).to eq 7..9
  end
end

describe '#fully_contains?' do
  it 'should return a boolean' do
    expect(fully_contains?([2..4, 6..8])).to be_a FalseClass
    expect(fully_contains?([6..6, 4..6])).to be_a TrueClass
  end

  it 'should return False if does not fully contain the other' do
    expect(fully_contains?([2..4, 6..8])).to eq false
    expect(fully_contains?([2..3, 4..5])).to eq false
    expect(fully_contains?([5..7, 7..9])).to eq false
    expect(fully_contains?([2..6, 4..8])).to eq false
  end

  it 'should return True if one fully contains the other' do
    expect(fully_contains?([2..8, 3..7])).to eq true
    expect(fully_contains?([6..6, 4..6])).to eq true
  end
end

describe '#overlaps?' do
  it 'should return a boolean' do
    expect(overlaps?([2..4, 6..8])).to be_a FalseClass
    expect(overlaps?([6..6, 4..6])).to be_a TrueClass
  end

  it 'should return False if one overlaps with the other' do
    expect(overlaps?([2..4, 6..8])).to eq false
    expect(overlaps?([2..3, 4..5])).to eq false
  end

  it 'should return True if one elf fully contains the other' do
    expect(overlaps?([5..7, 7..9])).to eq true
    expect(overlaps?([2..8, 3..7])).to eq true
    expect(overlaps?([6..6, 4..6])).to eq true
    expect(overlaps?([2..6, 4..8])).to eq true
  end
end

describe '#solve2' do
  it 'should return the correct result' do
    expect(solve2(example)).to eq 4
  end
end
