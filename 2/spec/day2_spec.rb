require_relative '../lib/day2'
example = File.read(File.join(__dir__, '../lib/example.txt'))

describe '#solve1' do
  it 'should be zero if no instructions' do
    expect(solve1('')).to eq(0)
  end

  it 'should compute the losses' do
    expect(solve1('A Z')).to eq(3) # rock VS scissors
    expect(solve1('B X')).to eq(1) # paper VS rock
    expect(solve1('C Y')).to eq(2) # scissors VS paper
  end

  it 'should compute the draws' do
    expect(solve1('A X')).to eq(4) # rock VS rock
    expect(solve1('B Y')).to eq(5) # paper VS paper
    expect(solve1('C Z')).to eq(6) # scissors VS scissors
  end

  it 'should compute the wins' do
    expect(solve1('A Y')).to eq(8) # rock VS paper
    expect(solve1('B Z')).to eq(9) # paper VS scissors
    expect(solve1('C X')).to eq(7) # scissors VS rock
  end

  it 'should sum the plays' do
    expect(solve1(example)).to eq(15)
  end
end

describe '#solve2' do
  it 'should be zero if no instructions' do
    expect(solve2('')).to eq(0)
  end

  it 'should compute the losses' do
    expect(solve2('A X')).to eq(3) # rock VS scissors
    expect(solve2('B X')).to eq(1) # paper VS rock
    expect(solve2('C X')).to eq(2) # scissors VS paper
  end

  it 'should compute the draws' do
    expect(solve2('A Y')).to eq(4) # rock
    expect(solve2('B Y')).to eq(5) # paper
    expect(solve2('C Y')).to eq(6) # scissors
  end

  it 'should compute the wins' do
    expect(solve2('A Z')).to eq(8) # rock VS paper
    expect(solve2('B Z')).to eq(9) # paper VS scissors
    expect(solve2('C Z')).to eq(7) # scissors VS rock
  end

  it 'should sum the plays' do
    expect(solve2(example)).to eq(12)
  end
end
