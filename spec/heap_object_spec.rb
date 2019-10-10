# frozen_string_literal: true

require 'benchmark'
require_relative '../src/heap_object.rb'

RSpec.describe Heap do
  let(:heap) { described_class.new }

  describe 'push pop' do
    it 'first pop' do
      expect(heap.pop).to eq(nil)
    end

    it 'push(1) pop' do
      heap.push(1)
      expect(heap.pop).to eq(1)
    end

    it 'push(2) pop' do
      heap.push(2)
      expect(heap.pop).to eq(2)
    end

    it 'push(1) push(2) pop pop' do
      heap.push(1)
      heap.push(2)
      expect([heap.pop, heap.pop]).to eq([1, 2])
    end

    it 'push(2) push(1) pop pop' do
      heap.push(2)
      heap.push(1)
      expect([heap.pop, heap.pop]).to eq([1, 2])
    end

    it 'push(1) push(2) push(3) pop pop pop' do
      heap.push(1)
      heap.push(2)
      heap.push(3)
      expect([heap.pop, heap.pop, heap.pop]).to eq([1, 2, 3])
    end

    it 'push(2) push(3) push(1) pop pop pop' do
      heap.push(2)
      heap.push(3)
      heap.push(1)
      expect([heap.pop, heap.pop, heap.pop]).to eq([1, 2, 3])
    end

    it 'push(1).push(2).push(3) pop pop pop' do
      heap.push(1).push(2).push(3)
      expect([heap.pop, heap.pop, heap.pop]).to eq([1, 2, 3])
    end

    it 'push(2).push(3).push(1) pop pop pop' do
      heap.push(2).push(3).push(1)
      expect([heap.pop, heap.pop, heap.pop]).to eq([1, 2, 3])
    end
  end

  describe 'push(*) pop pop pop' do
    it 'push(1, 2 ,3) pop' do
      heap.push(1, 2, 3)
      expect([heap.pop, heap.pop, heap.pop]).to eq([1, 2, 3])
    end

    it 'push(2, 3 ,1) pop pop pop' do
      heap.push(2, 3, 1)
      expect([heap.pop, heap.pop, heap.pop]).to eq([1, 2, 3])
    end
  end

  describe 'push(*) pop' do
    it 'push(1, 2 ,3) pop pop pop' do
      heap.push(1, 2, 3)
      expect([heap.pop, heap.pop, heap.pop]).to eq([1, 2, 3])
    end

    it 'push(2, 3 ,1) pop pop pop' do
      heap.push(2, 3, 1)
      expect([heap.pop, heap.pop, heap.pop]).to eq([1, 2, 3])
    end
  end

  describe 'pop(num)' do
    it 'push(2, 3, 1) pop(0)' do
      heap.push(2, 3, 1)
      expect(heap.pop(0)).to be_nil
    end

    it 'push(2, 3, 1) pop(1)' do
      heap.push(2, 3, 1)
      expect(heap.pop(1)).to eq(1)
    end

    it 'push(2, 3 ,1) pop(2)' do
      heap.push(2, 3, 1)
      expect(heap.pop(2)).to eq([1, 2])
    end

    it 'push(2, 3 ,1) pop(3)' do
      heap.push(2, 3, 1)
      expect(heap.pop(3)).to eq([1, 2, 3])
    end

    it 'push(2, 3 ,1) pop(4)' do
      heap.push(2, 3, 1)
      expect(heap.pop(4)).to eq([1, 2, 3])
    end
  end

  describe 'pop_all' do
    it 'push(2, 3, 1) pop_all' do
      heap.push(2, 3, 1)
      expect(heap.pop_all).to eq([1, 2, 3])
    end

    it 'push(2, 3, 1) pop_all pop_all' do
      heap.push(2, 3, 1)
      expect([heap.pop_all, heap.pop_all]).to eq([[1, 2, 3], nil])
    end
  end

  describe 'to_a' do
    it 'push(2, 3, 1) to_a' do
      heap.push(2, 3, 1)
      expect(heap.to_a).to eq([1, 2, 3])
    end

    it 'push(2, 3, 1) to_a to_a' do
      heap.push(2, 3, 1)
      expect([heap.to_a, heap.to_a]).to eq([[1, 2, 3], [1, 2, 3]])
    end
  end

  describe 'comparison block' do
    it '降順で' do
      heap = described_class.new { |a, b| a > b }
      heap.push(2, 3, 1)
      expect(heap.to_a).to eq([3, 2, 1])
    end

    it '適当なメソッド結果で' do
      heap = described_class.new { |a, b| a.size < b.size }
      heap.push('aa', 'aaaa', 'a', 'aaa')
      expect(heap.to_a).to eq(['a', 'aa', 'aaa', 'aaaa'])
    end
  end

  context 'with いっぱい' do
    it 'いっぱい' do
      500.times { heap.push(rand(100)) }
      expect(heap.pop_all.each_cons(2).all? { |a, b| a <= b }).to be true
    end
  end
end

RSpec.configure do |config|
  config.after(:suite) do
    puts ''
    COUNT = 5_000
    items = Array.new(COUNT) { rand(COUNT) }
    pushed_heap = Heap.new.push(*items)

    Benchmark.bm(8) do |x|
      heap = Heap.new
      x.report('push * n') do
        items.each { |item| heap.push(item) }
      end

      heap = Heap.new
      x.report('push(*n)') do
        heap.push(*items)
      end

      heap = pushed_heap.dup
      x.report('pop * n') do
        COUNT.times { heap.pop }
      end

      heap = pushed_heap.dup
      x.report('pop_all') do
        heap.pop_all
      end

      heap = pushed_heap.dup
      x.report('to_a') do
        heap.to_a
      end
    end
  end
end
