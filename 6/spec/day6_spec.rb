require_relative '../lib/day6'
examples = File.read(File.join(__dir__, '../lib/example.txt')).lines.map(&:chomp)

describe '#solve1' do
  it 'should return the right number' do
    expect(solve1(examples[0])).to eq 7
    expect(solve1(examples[1])).to eq 5
    expect(solve1(examples[2])).to eq 6
    expect(solve1(examples[3])).to eq 10
    expect(solve1(examples[4])).to eq 11
  end
end

describe '#solve2' do
  it 'should return the right number' do
    expect(solve2(examples[0])).to eq 19
    expect(solve2(examples[1])).to eq 23
    expect(solve2(examples[2])).to eq 23
    expect(solve2(examples[3])).to eq 29
    expect(solve2(examples[4])).to eq 26
  end
end
