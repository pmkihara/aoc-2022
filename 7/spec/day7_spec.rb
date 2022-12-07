require_relative '../lib/day7'
example = File.read(File.join(__dir__, '../lib/example.txt'))

directories = {
  '/' => {
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
}

describe '#prepare_input' do
  let(:prepared_input) { prepare_input(example) }

  it 'should return a Hash' do
    expect(prepared_input).to be_a Hash
  end

  it 'should create the filesystem' do
    expect(prepared_input).to eq directories
  end
end

describe '#calculate_directory_size' do
  it 'should return the right directory size' do
    expect(calculate_directory_size(directories['/']['a']['e'])).to eq 584
    expect(calculate_directory_size(directories['/']['a'])).to eq 94853
    expect(calculate_directory_size(directories['/']['d'])).to eq 24933642
    expect(calculate_directory_size(directories['/'])).to eq 48381165
  end
end

describe '#solve1' do
  it 'should return the correct value' do
    expect(solve1(example)).to eq 95437
  end
end

describe '#solve2' do
  it 'should return the correct value' do
    expect(solve2(example)).to eq 24933642
  end
end
