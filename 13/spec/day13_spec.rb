require_relative '../lib/day13'
example = File.read(File.join(__dir__, '../lib/example.txt'))

describe '#prepare_input' do
  it 'should return an array with each pair' do
    expect(prepare_input(example)).to be_a Array
    expect(prepare_input(example)[0]).to be_a Array
  end

  it 'should parse a nested Array' do
    expect(prepare_input("[1,[2,[3,[4,[5,6,7]]]],8,9]\n[1,[2,[3,[4,[5,6,0]]]],8,9]\n")[0]).to eq [[1, [2, [3, [4, [5, 6, 7]]]], 8, 9], [1, [2, [3, [4, [5, 6, 0]]]], 8, 9]]
  end

  it 'should parse the integers' do
    expect(prepare_input("[1,1,3,1,1]\n[1,1,5,1,1]")[0][0][0]).to be_a Integer
  end
end

describe '#right_order?' do
  it 'should compare two integers' do
    expect(right_order?([1], [2])).to eq true
    expect(right_order?([2], [1])).to eq false
  end

  it 'should check the next part if both are the same integer' do
    expect(right_order?([1, 1], [1, 2])).to eq true
    expect(right_order?([1, 2], [1, 1])).to eq false
  end

  it 'should compare two lists' do
    expect(right_order?([1], [2])).to eq true
    expect(right_order?([2], [1])).to eq false
  end

  it 'should compare lists of different sizes' do
    expect(right_order?([1, 2], [1, 2, 3])).to eq true
    expect(right_order?([1, 2, 3], [1, 2])).to eq false
  end

  it 'should convert a single integer when comparing it to a list' do
    expect(right_order?([0, 0, 0], 2)).to eq true
  end

  it 'should return the correct value' do
    expect(right_order?([1, 1, 3, 1, 1], [1, 1, 5, 1, 1])).to eq true
    expect(right_order?([[1], [2, 3, 4]], [[1], 4])).to eq true
    expect(right_order?([9], [[8,7,6]])).to eq false
    expect(right_order?([[4,4],4,4], [[4,4],4,4,4])).to eq true
    expect(right_order?([7,7,7,7], [7,7,7])).to eq false
    expect(right_order?([], [3])).to eq true
    expect(right_order?([[[]]], [[]])).to eq false
    expect(right_order?([1,[2,[3,[4,[5,6,7]]]],8,9], [1,[2,[3,[4,[5,6,0]]]],8,9])).to eq false
  end
end

describe '#solve1' do
  it 'should return the correct value' do
    expect(solve1(example)).to eq 13
  end
end

describe '#solve2' do
  it 'should return the correct value' do
    expect(solve2(example)).to eq 140
  end
end
