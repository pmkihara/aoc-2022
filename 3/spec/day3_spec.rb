require_relative '../lib/day3'
example = File.read(File.join(__dir__, '../lib/example.txt'))

describe '#prepare_input' do
  let(:formated_example) { prepare_input(example) }

  it 'should separate lines in an array' do
    expect(formated_example).to be_a Array
    expect(formated_example.size).to eq 6
  end
end

describe '#split_line_in_half' do
  let (:splited_line) { split_line_in_half('vJrwpWtwJgWrhcsFMMfFFhFp') }

  it 'should separate each lines in two arrays with the same size' do
    expect(splited_line).to be_a Array
    expect(splited_line.size).to eq 2
    expect(splited_line[0].size).to eq splited_line[1].size
  end
end

describe '#find_repeated_letter' do
  it 'should return a letter' do
    expect(find_repeated_letter('vJrwpWtwJgWrhcsFMMfFFhFp')).to be_a String
    expect(find_repeated_letter('vJrwpWtwJgWrhcsFMMfFFhFp').length).to eq 1
  end

  it 'should find the repeated letter' do
    expect(find_repeated_letter('vJrwpWtwJgWrhcsFMMfFFhFp')).to eq 'p'
    expect(find_repeated_letter('jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL')).to eq 'L'
    expect(find_repeated_letter('PmmdzqPrVvPwwTWBwg')).to eq 'P'
    expect(find_repeated_letter('wMqvLMZHhHMvwLHjbvcjnnSBnvTQFn')).to eq 'v'
    expect(find_repeated_letter('ttgJtRGJQctTZtZT')).to eq 't'
    expect(find_repeated_letter('CrZsJsPPZsGzwwsLwLmpwMDw')).to eq 's'
  end
end

describe '#split_in_groups_of_three' do
  let(:groups) { split_in_groups_of_three(["vJrwpWtwJgWrhcsFMMfFFhFp", "jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL", "PmmdzqPrVvPwwTWBwg", "wMqvLMZHhHMvwLHjbvcjnnSBnvTQFn", "ttgJtRGJQctTZtZT", "CrZsJsPPZsGzwwsLwLmpwMDw"]) }

  it 'should return an array' do
    expect(groups).to be_a Array
  end

  it 'should return an array with 3 elements' do
    expect(groups[0].length).to eq 3
  end
end

describe '#find_common_letter_in_group' do
  let(:group1) { ["vJrwpWtwJgWrhcsFMMfFFhFp", "jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL", "PmmdzqPrVvPwwTWBwg"] }
  let(:group2) { ["wMqvLMZHhHMvwLHjbvcjnnSBnvTQFn", "ttgJtRGJQctTZtZT", "CrZsJsPPZsGzwwsLwLmpwMDw"] }

  it 'should return a letter' do
    expect(find_common_letter_in_group(group1)).to be_a String
    expect(find_common_letter_in_group(group1).length).to eq 1
  end

  it 'should find the right letter' do
    expect(find_common_letter_in_group(group1)).to eq 'r'
    expect(find_common_letter_in_group(group2)).to eq 'Z'

  end
end

describe '#solve1' do
  it 'should get the correct sum' do
    expect(solve1(example)).to eq 157
  end
end

describe '#solve2' do
  it 'should get the correct sum' do
    expect(solve2(example)).to eq 70
  end
end
