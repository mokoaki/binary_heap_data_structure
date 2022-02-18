# frozen_string_literal: true

RSpec.describe Heap do
  let(:heap) { described_class.new }

  describe "push pop" do
    it "init pop" do
      expect(heap.pop).to be_nil
    end

    it "push(1) pop" do
      heap.push(1)
      expect(heap.pop).to match([1])
    end

    it "push(2) pop" do
      heap.push(2)
      expect(heap.pop).to match([2])
    end

    it "push(1) push(2) push(3) pop pop pop" do
      heap.push(1)
      heap.push(2)
      heap.push(3)
      expect(heap.pop).to match([1])
      expect(heap.pop).to match([2])
      expect(heap.pop).to match([3])
    end

    it "push(2) push(3) push(1) pop pop pop" do
      heap.push(2)
      heap.push(3)
      heap.push(1)
      expect(heap.pop).to match([1])
      expect(heap.pop).to match([2])
      expect(heap.pop).to match([3])
    end

    it "push(1).push(2).push(3) pop pop pop" do
      heap.push(1).push(2).push(3)
      expect(heap.pop).to match([1])
      expect(heap.pop).to match([2])
      expect(heap.pop).to match([3])
    end

    it "push(2).push(3).push(1) pop pop pop" do
      heap.push(2).push(3).push(1)
      expect(heap.pop).to match([1])
      expect(heap.pop).to match([2])
      expect(heap.pop).to match([3])
    end

    it "push(1, 2, 3) pop pop pop" do
      heap.push(1, 2, 3)
      expect(heap.pop).to match([1])
      expect(heap.pop).to match([2])
      expect(heap.pop).to match([3])
    end

    it "push(2, 3, 1) pop pop pop" do
      heap.push(2, 3, 1)
      expect(heap.pop).to match([1])
      expect(heap.pop).to match([2])
      expect(heap.pop).to match([3])
    end
  end

  describe "pop(nums)" do
    it "pop" do
      expect(heap.pop).to be_nil
    end

    it "pop(0)" do
      expect(heap.pop(0)).to be_nil
    end

    it "pop(1)" do
      expect(heap.pop(1)).to be_nil
    end

    it "push(2, 3, 1) pop" do
      heap.push(2, 3, 1)
      expect(heap.pop).to match([1])
    end

    it "push(2, 3, 1) pop(0)" do
      heap.push(2, 3, 1)
      expect(heap.pop(0)).to match([])
    end

    it "push(2, 3, 1) pop(1)" do
      heap.push(2, 3, 1)
      expect(heap.pop(1)).to match([1])
    end

    it "push(2, 3 ,1) pop(2)" do
      heap.push(2, 3, 1)
      expect(heap.pop(2)).to match([1, 2])
    end

    it "push(2, 3 ,1) pop(3)" do
      heap.push(2, 3, 1)
      expect(heap.pop(3)).to match([1, 2, 3])
      expect(heap.pop).to be_nil
    end

    it "push(2, 3 ,1) pop(4)" do
      heap.push(2, 3, 1)
      expect(heap.pop(4)).to match([1, 2, 3])
      expect(heap.pop).to be_nil
    end
  end

  describe "first" do
    it "push(1, 2, 3) first" do
      heap.push(1, 2, 3)
      expect(heap.first).to eq(1)
    end

    it "push(2, 1, 3) first" do
      heap.push(2, 1, 3)
      expect(heap.first).to eq(1)
    end

    it "push(2, 3, 1) first" do
      heap.push(2, 3, 1)
      expect(heap.first).to eq(1)
    end
  end

  describe "size" do
    it "init size" do
      expect(heap.size).to eq(0)
    end

    it "push(1) size" do
      heap.push(1)
      expect(heap.size).to eq(1)
    end

    it "push(1, 2) size" do
      heap.push(1, 2)
      expect(heap.size).to eq(2)
    end
  end

  describe "pop_all" do
    it "push(2, 3, 1) pop_all" do
      heap.push(2, 3, 1)
      expect(heap.pop_all).to match([1, 2, 3])
      expect(heap.pop).to be_nil
    end
  end

  describe "to_a" do
    it "push(2, 3, 1) to_a" do
      heap.push(2, 3, 1)
      expect(heap.to_a).to match([1, 2, 3])
      expect(heap.pop).to match([1])
    end
  end

  describe "comparison block" do
    it "昇順で" do
      heap = described_class.new { |a, b| a < b }
      heap.push(2, 3, 1)
      expect(heap.to_a).to match([1, 2, 3])
    end

    it "降順で" do
      heap = described_class.new { |a, b| a > b }
      heap.push(2, 3, 1)
      expect(heap.to_a).to match([3, 2, 1])
    end

    it "適当なメソッド結果で" do
      heap = described_class.new { |a, b| a.size < b.size }
      heap.push("aa", "aaaa", "a", "aaa")
      expect(heap.to_a).to match(["a", "aa", "aaa", "aaaa"])
    end
  end

  describe "initialize arguments" do
    it "new(2, 3, 1)" do
      heap = described_class.new(2, 3, 1)
      expect(heap.to_a).to match([1, 2, 3])
    end
  end

  context "いっぱい" do
    it "いっぱい" do
      1000.times { heap.push(rand(100)) }
      expect(heap.pop_all.each_cons(2).all? { |a, b| a <= b }).to be(true)
    end
  end
end
