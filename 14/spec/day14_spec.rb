require_relative '../lib/day14'
example = File.read(File.join(__dir__, '../lib/example.txt'))

# prepared_input = prepare_input(example)
# describe '#prepare_input' do
#   it 'should instantiate the rocks' do
#     expect(prepared_input).to be_a Array
#     expect(prepared_input.length).to eq 2
#     p prepared_input
#   end

#   it 'should split the coordinates of each line' do
#     expect(prepared_input[0]).to be_a Array
#     expect(prepared_input[0]).to eq ["498,4", "498,6", "496,6"]
#     expect(prepared_input[1]).to be_a Array
#     expect(prepared_input[1]).to eq ["503,4", "502,4", "502,9", "494,9"]
#   end
# end

# describe '#create_rocks' do
#   it 'should instantiate the rocks' do
#     create_rocks(prepared_input)
#     expect(Cave.all).to be_a Array
#     expect(Cave.all.length).to eq 20
#   end
# end

# describe '#solve1' do
#   before(:all) do
#     Object.send(:remove_const, 'Cave')
#     load 'lib/day14.rb'
#   end

#   it 'should return the correct value' do
#     expect(solve1(example)).to eq 24
#   end
# end

describe '#solve2' do
  before(:all) do
    Object.send(:remove_const, 'Cave')
    load 'lib/day14.rb'
  end

  it 'should return the correct value' do
    expect(solve2(example)).to eq 93
  end
end
