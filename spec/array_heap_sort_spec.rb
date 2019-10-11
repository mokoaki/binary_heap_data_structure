# frozen_string_literal: true

RSpec.describe Array do
  describe 'Array#heap_sort!' do
    it 'empty array' do
      expect([].heap_sort!).to eq([])
    end

    it '[1, 2, 3].heap_sort!' do
      expect([1, 2, 3].heap_sort!).to eq([1, 2, 3])
    end

    it '[2, 3, 1].heap_sort!' do
      expect([2, 3, 1].heap_sort!).to eq([1, 2, 3])
    end

    it 'original object' do
      original = [2, 3, 1]
      original.heap_sort!
      expect(original).to eq([1, 2, 3])
    end
  end

  describe 'Array#heap_sort' do
    it 'empty array' do
      expect([].heap_sort).to eq([])
    end

    it '[1, 2, 3].heap_sort' do
      expect([1, 2, 3].heap_sort).to eq([1, 2, 3])
    end

    it '[2, 3, 1].heap_sort' do
      expect([2, 3, 1].heap_sort).to eq([1, 2, 3])
    end

    it 'original object' do
      original = [2, 3, 1]
      original.heap_sort
      expect(original).to eq([2, 3, 1])
    end
  end

  context 'with いっぱい' do
    it 'いっぱい' do
      items = described_class.new(500) { rand(500) }
      expect(items.heap_sort!.each_cons(2).all? { |a, b| a <= b }).to be(true)
    end
  end
end
