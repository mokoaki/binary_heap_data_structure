# frozen_string_literal: true

require 'benchmark'
require_relative '../heap_object.rb'

RSpec.describe Heap do
  describe '#push #pop' do
    let(:heap) { described_class.new }

    it 'push(1) push(2) push(3) pop(1) pop(2) pop(3)' do
      heap.push(1)
      heap.push(2)
      heap.push(3)
      expect(heap.pop).to eq(1)
      expect(heap.pop).to eq(2)
      expect(heap.pop).to eq(3)
    end

    it 'push(2) push(3) push(1) pop(1) pop(2) pop(3)' do
      heap.push(3)
      heap.push(2)
      heap.push(1)
      expect(heap.pop).to eq(1)
      expect(heap.pop).to eq(2)
      expect(heap.pop).to eq(3)
    end

    it 'push(2) push(1) push(3) pop(1) pop(2) pop(3)' do
      heap.push(3)
      heap.push(1)
      heap.push(2)
      expect(heap.pop).to eq(1)
      expect(heap.pop).to eq(2)
      expect(heap.pop).to eq(3)
    end

    it 'push(1, 2, 3) pop(1) pop(2) pop(3)' do
      heap.push(1, 2, 3)
      expect(heap.pop).to eq(1)
      expect(heap.pop).to eq(2)
      expect(heap.pop).to eq(3)
    end

    it 'push(3, 2, 1) pop(1) pop(2) pop(3)' do
      heap.push(2, 3, 1)
      expect(heap.pop).to eq(1)
      expect(heap.pop).to eq(2)
      expect(heap.pop).to eq(3)
    end

    it 'push(2, 3) push(1) pop(1) pop(2) pop(3)' do
      heap.push(2, 3)
      heap.push(1)
      expect(heap.pop).to eq(1)
      expect(heap.pop).to eq(2)
      expect(heap.pop).to eq(3)
    end

    it 'push(2, 3) push(4, 1) pop(1) pop(2) pop(3)' do
      heap.push(2, 3)
      heap.push(4, 1)
      expect(heap.pop).to eq(1)
      expect(heap.pop).to eq(2)
      expect(heap.pop).to eq(3)
      expect(heap.pop).to eq(4)
    end
  end

  describe '#new #pop' do
    it 'new(1) push(2) push(3) pop(1) pop(2) pop(3)' do
      heap = described_class.new(1)
      heap.push(2)
      heap.push(3)
      expect(heap.pop).to eq(1)
      expect(heap.pop).to eq(2)
      expect(heap.pop).to eq(3)
    end

    it 'new(2) push(3) push(1) pop(1) pop(2) pop(3)' do
      heap = described_class.new(2)
      heap.push(3)
      heap.push(1)
      expect(heap.pop).to eq(1)
      expect(heap.pop).to eq(2)
      expect(heap.pop).to eq(3)
    end

    it 'new(2) push(1) push(3) pop(1) pop(2) pop(3)' do
      heap = described_class.new(2)
      heap.push(1)
      heap.push(3)
      expect(heap.pop).to eq(1)
      expect(heap.pop).to eq(2)
      expect(heap.pop).to eq(3)
    end

    it 'new(1, 2, 3) pop(1) pop(2) pop(3)' do
      heap = described_class.new(1, 2, 3)
      expect(heap.pop).to eq(1)
      expect(heap.pop).to eq(2)
      expect(heap.pop).to eq(3)
    end

    it 'new(3, 2, 1) pop(1) pop(2) pop(3)' do
      heap = described_class.new(3, 2, 1)
      expect(heap.pop).to eq(1)
      expect(heap.pop).to eq(2)
      expect(heap.pop).to eq(3)
    end

    it 'new(2, 3, 1) pop(1) pop(2) pop(3)' do
      heap = described_class.new(2, 3, 1)
      expect(heap.pop).to eq(1)
      expect(heap.pop).to eq(2)
      expect(heap.pop).to eq(3)
    end

    it 'new(2, 3) push(1) pop(1) pop(2) pop(3)' do
      heap = described_class.new(2, 3)
      heap.push(1)
      expect(heap.pop).to eq(1)
      expect(heap.pop).to eq(2)
      expect(heap.pop).to eq(3)
    end

    it 'new(2, 3) push(4, 1) pop(1) pop(2) pop(3)' do
      heap = described_class.new(2, 3)
      heap.push(4, 1)
      expect(heap.pop).to eq(1)
      expect(heap.pop).to eq(2)
      expect(heap.pop).to eq(3)
      expect(heap.pop).to eq(4)
    end
  end

  describe '#to_a!' do
    it 'new(2, 3, 1) push(5, 6, 4) to_a!(1, 2, 3)' do
      heap = described_class.new(2, 3, 1)
      heap.push(5, 6, 4)
      expect(heap.to_a!).to eq([1, 2, 3, 4, 5, 6])
    end
  end

  describe '#push method chaining' do
    it 'new(2).push(3, 1) to_a!' do
      heap = described_class.new(2).push(3, 1)
      expect(heap.to_a!).to eq([1, 2, 3])
    end

    it 'push(2).push(3, 1) to_a!' do
      heap = described_class.new
      heap.push(2).push(3, 1)
      expect(heap.to_a!).to eq([1, 2, 3])
    end
  end

  context 'setting sort' do
    it '降順' do
      heap = described_class.new { |a, b| a > b }
      heap.push(2, 3, 1)
      expect(heap.to_a!).to eq([3, 2, 1])
    end

    it 'メソッドの戻り値とかでソート' do
      heap = described_class.new { |a, b| a.size > b.size }
      heap.push('333', '1', '4444', '22')
      expect(heap.to_a!).to eq(['4444', '333', '22', '1'])
    end
  end

  context 'いっぱい' do
    it 'いっぱい' do
      data = Array.new(500) { rand(200) }
      heap = described_class.new(*data)
      expect(heap.to_a!.each_cons(2)).to be_all { |a, b| a <= b }
    end
  end
end

RSpec.configure do |config|
  config.after(:suite) do
    puts ''
    Benchmark.bm(12) do |x|
      x.report('sort[200000]') do
        count = 200_000
        data = Array.new(count) { rand(count) }
        Heap.new.push(*data).to_a!
      end
    end
  end
end
