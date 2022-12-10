require_relative '../lib/day10'
example = File.read(File.join(__dir__, '../lib/example.txt'))
example_signal = { 20 => 21, 60 => 19, 100 => 18, 140 => 21, 180 => 16, 220 => 18 }

describe '#signal_strengths' do
  it 'should return the x value in the markpoint cycles' do
    expect(signal_strengths(example)).to eq example_signal
  end
end

describe '#solve1' do
  it 'should return the correct value' do
    expect(solve1(example)).to eq 13_140
  end
end

describe '#draw_lines' do
  it 'should return the correct image' do
    expect(draw_lines(example)[0]).to eq '##  ##  ##  ##  ##  ##  ##  ##  ##  ##  '
    expect(draw_lines(example)[1]).to eq '###   ###   ###   ###   ###   ###   ### '
    expect(draw_lines(example)[2]).to eq '####    ####    ####    ####    ####    '
    expect(draw_lines(example)[3]).to eq '#####     #####     #####     #####     '
    expect(draw_lines(example)[4]).to eq '######      ######      ######      ####'
    expect(draw_lines(example)[5]).to eq '#######       #######       #######     '
  end
end
