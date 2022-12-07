require_relative '../lib/day7'
example = File.read(File.join(__dir__, '../lib/example.txt')).lines.map(&:chomp)

directories = {
  'a' => {
    'e' => {
      files: {
        'i' => 584
      }
    },
    files: {
      'f' => 29116,
      'g' => 2557,
      'h.lst' => 62596
    }
  },
  files: {
    'b.txt' => 14848514,
    'c.dat' => 8504156,
  },
  'd' => {
    files: {
      'j' => 4060174,
      'd.log' => 8033020,
      'd.ext' => 5626152,
      'k' => 7214296
    }
  }
}

describe '#prepare_input' do
  let(:prepared_input) { prepare_input(example) }
  let(:commands) { prepared_input[:commands] }
  let(:filesystem) { prepared_input[:filesystem] }

  it 'should return a Hash' do
    expect(prepared_input).to be_a Hash
  end

  it 'should separate the commands and the filesystem' do
    expect(commands).to be_truthy
    expect(filesystem).to be_truthy
  end

  it 'should return the commands as an Array' do
    expect(commands).to be_a Array
    expect(commands).to eq [
      '$ cd /',
      '$ ls',
      '$ cd a',
      '$ ls',
      '$ cd e',
      '$ ls',
      '$ cd ..',
      '$ cd ..',
      '$ cd d',
      '$ ls'
    ]
  end

  it 'should return the filesystem as a Hash' do
    expect(filesystem).to be_a Hash
    expect(filesystem).to eq directories
  end
end

describe '#calculate_directory_size' do
  it 'should return the right directory size' do
    expect(calculate_directory_size(directories['a']['e'])).to eq 584
    expect(calculate_directory_size(directories['a'])).to eq 94853
    expect(calculate_directory_size(directories['d'])).to eq 24933642
    expect(calculate_directory_size(directories)).to eq 48381165
  end
end

describe '#solve1' do
  it 'should return the correct value' do
    expect(solve1(example)).to eq 95437
  end
end
