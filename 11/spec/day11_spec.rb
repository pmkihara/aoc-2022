require_relative '../lib/day11'
example = File.read(File.join(__dir__, '../lib/example.txt'))

monkey0_attrs = {
  monkey_number: 0,
  starting_items: [79, 98],
  operation: 'old * 19',
  denominator: 23,
  true_monkey: 2,
  false_monkey: 3
}

monkey3_attrs = {
  monkey_number: 3,
  starting_items: [74],
  operation: 'old + 3',
  denominator: 17,
  true_monkey: 0,
  false_monkey: 1
}

describe Monkey do
  let(:monkey0) { Monkey.new(monkey0_attrs) }
  let(:monkey3) { Monkey.new(monkey3_attrs) }

  describe '#initialize' do
    it 'should instantiate a Monkey' do
      expect(monkey0).to be_a Monkey
      expect(monkey3).to be_a Monkey
    end

    it 'should define an instance variable @monkey_number' do
      expect(monkey0.instance_variable_get(:@monkey_number)).to eq 0
    end

    it 'should define an instance variable @items' do
      expect(monkey0.instance_variable_get(:@items)).to be_a Array
      expect(monkey0.instance_variable_get(:@items)).to eq [79, 98]
    end

    it 'should define an instance variable @operation' do
      expect(monkey0.instance_variable_get(:@operation)).to eq 'old * 19'
    end

    it 'should define an instance variable @denominator' do
      expect(monkey0.instance_variable_get(:@denominator)).to eq 23
    end

    it 'should define an instance variable @true_monkey' do
      expect(monkey0.instance_variable_get(:@true_monkey)).to eq 2
    end

    it 'should define an instance variable @false_monkey' do
      expect(monkey0.instance_variable_get(:@false_monkey)).to eq 3
    end
  end

  describe '#inspect_items!' do
    it 'should toss the item to the next monkey' do
      monkey0.inspect_items!
      expect(monkey0.items).to eq []
      expect(monkey3.items).to eq [74, 500, 620]
    end
  end
end

describe '#create_monkeys' do
  it 'should return an array of Monkeys' do
    expect(create_monkeys(example)).to be_a Array
    expect(create_monkeys(example).length).to eq 4
    expect(create_monkeys(example)[0]).to be_a Monkey
  end
end

describe '#solve1' do
  before(:all) do
    Object.send(:remove_const, 'Monkey')
    load 'lib/day11.rb'
  end

  it 'should return the correct value' do
    expect(solve1(example)).to eq 10_605
  end
end

describe '#solve2' do
  before(:all) do
    Object.send(:remove_const, 'Monkey')
    load 'lib/day11.rb'
  end

  it 'should return the correct value' do
    expect(solve2(example)).to eq 2_713_310_158
  end
end
