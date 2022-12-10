require_relative '../lib/day9'
example = File.read(File.join(__dir__, '../lib/example.txt'))
example2 = File.read(File.join(__dir__, '../lib/example2.txt'))

describe Rope do
  describe '#initialize' do
    it 'should define an instance variable @size' do
      expect(Rope.new({ size: 2 }).instance_variable_get(:@size)).to eq 2
    end

    it 'should define an instance variable @knots' do
      expect(Rope.new({ size: 2 }).instance_variable_get(:@knots)).to be_an Array
      expect(Rope.new({ size: 2 }).instance_variable_get(:@knots).length).to eq 2
      expect(Rope.new({ size: 10 }).instance_variable_get(:@knots).length).to eq 10
    end

    it 'should define an instance variable @tail_stracks' do
      expect(Rope.new({ size: 2 }).instance_variable_get(:@tail_tracks)).to be_a Set
      expect(Rope.new({ size: 2 }).instance_variable_get(:@tail_tracks).length).to eq 1
    end
  end

  describe '#move' do
    let(:rope) { Rope.new({ size: 3 }) }

    it 'should move the head and the all knots' do
      rope.move('U', 5)
      expect(rope.instance_variable_get(:@knots)[0]).to eq Hash[x: 0, y: 5]
      expect(rope.instance_variable_get(:@knots)[1]).to eq Hash[x: 0, y: 4]
      expect(rope.instance_variable_get(:@knots)[2]).to eq Hash[x: 0, y: 3]
    end

    describe 'head' do
      it 'should move up' do
        rope.move('U', 2)
        expect(rope.instance_variable_get(:@knots)[0]).to eq Hash[x: 0, y: 2]
      end

      it 'should move down' do
        rope.move('D', 2)
        expect(rope.instance_variable_get(:@knots)[0]).to eq Hash[x: 0, y: -2]
      end

      it 'should move left' do
        rope.move('L', 2)
        expect(rope.instance_variable_get(:@knots)[0]).to eq Hash[x: -2, y: 0]
      end

      it 'should move right' do
        rope.move('R', 2)
        expect(rope.instance_variable_get(:@knots)[0]).to eq Hash[x: 2, y: 0]
      end
    end

    describe 'knots' do
      it 'should move the first knot according to the position of the head' do
        rope.move('U', 2)
        expect(rope.instance_variable_get(:@knots)[1]).to eq Hash[x: 0, y: 1]
      end

      it 'should move the other knots according to the position of the previous knot' do
        rope.move('U', 3)
        expect(rope.instance_variable_get(:@knots)[2]).to eq Hash[x: 0, y: 1]
      end

      it 'should not move the knot when the previous is above the knot' do
        rope.move('U', 2)
        rope.move('D', 2)
        expect(rope.instance_variable_get(:@knots)[1]).to eq Hash[x: 0, y: 1]
      end

      it 'should not move the knot when the previous is diagonal to the knot' do
        rope.move('U', 2)
        rope.move('R', 1)
        expect(rope.instance_variable_get(:@knots)[1]).to eq Hash[x: 0, y: 1]
      end

      it 'should move the knots diagonally' do
        rope.move('U', 2)
        rope.move('R', 2)
        expect(rope.instance_variable_get(:@knots)[1]).to eq Hash[x: 1, y: 2]
      end
    end
  end

  describe '#tail_tracks_count' do
    let(:rope) { Rope.new({ size: 3 }) }

    it 'should compute the places where the tail has been' do
      rope.move('U', 4)
      expect(rope.tail_tracks_count).to eq 3
    end

    it 'should not compute places where the tail has already been' do
      rope.move('U', 4)
      rope.move('D', 4)
      expect(rope.tail_tracks_count).to eq 3
    end
  end
end

describe '#solve1' do
  it 'should return the correct value' do
    expect(solve1(example)).to eq 13
  end
end

describe '#solve2' do
  it 'should return the correct value' do
    expect(solve2(example)).to eq 1
    expect(solve2(example2)).to eq 36
  end
end
