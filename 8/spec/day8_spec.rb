require_relative '../lib/day8'
example = File.read(File.join(__dir__, '../lib/example.txt'))
formated_example = [[3, 0, 3, 7, 3], [2, 5, 5, 1, 2], [6, 5, 3, 3, 2], [3, 3, 5, 4, 9], [3, 5, 3, 9, 0]]

describe '#prepare_input' do
  it 'should return an Array' do
    expect(prepare_input(example)).to be_a Array
  end

  it 'should return the formated input' do
    expect(prepare_input(example)).to eq formated_example
  end
end

describe 'TreeClass' do
  tree = Tree.new({ height: 2, edge: true })
  describe '#initialize' do
    it 'should instantiate a Tree' do
      expect(tree).to be_a Tree
    end
  end
end

describe '#solve1' do
  it 'should return the correct value' do
    expect(solve1(example)).to eq 21
  end
end

describe '#solve2' do
  it 'should return the correct value' do
    expect(solve2(example)).to eq 8
  end
end
