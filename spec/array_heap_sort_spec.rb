# frozen_string_literal: true

RSpec.describe Array do
  describe "Array#heap_sort!" do
    it "empty array" do
      expect([].heap_sort!).to eq([])
    end

    it "[1, 2, 3].heap_sort!" do
      expect([1, 2, 3].heap_sort!).to eq([1, 2, 3])
    end

    it "[2, 3, 1].heap_sort!" do
      expect([2, 3, 1].heap_sort!).to eq([1, 2, 3])
    end

    it "昇順で" do
      expect([2, 3, 1].heap_sort! { |a, b| a < b }).to eq([1, 2, 3])
    end

    it "降順で" do
      expect([2, 3, 1].heap_sort! { |a, b| a > b }).to eq([3, 2, 1])
    end

    it "original object" do
      original = [2, 3, 1]
      original.heap_sort!
      expect(original).to eq([1, 2, 3])
    end
  end

  describe "Array#heap_sort" do
    it "empty array" do
      expect([].heap_sort).to eq([])
    end

    it "[1, 2, 3].heap_sort" do
      expect([1, 2, 3].heap_sort).to eq([1, 2, 3])
    end

    it "[2, 3, 1].heap_sort" do
      expect([2, 3, 1].heap_sort).to eq([1, 2, 3])
    end

    it "昇順で" do
      expect([2, 3, 1].heap_sort { |a, b| a < b }).to eq([1, 2, 3])
    end

    it "降順で" do
      expect([2, 3, 1].heap_sort { |a, b| a > b }).to eq([3, 2, 1])
    end

    it "original object" do
      original = [2, 3, 1]
      original.heap_sort
      expect(original).to eq([2, 3, 1])
    end
  end

  context "いっぱい" do
    let(:items) do
      described_class.new(1000) { rand(1000) }
    end

    it "いっぱい" do
      expect(items.heap_sort.each_cons(2).all? { |a, b| a <= b }).to be(true)
    end

    it "heap_sort == heap_sort!" do
      expect(items.heap_sort).to eq(items.heap_sort!)
    end
  end
end
