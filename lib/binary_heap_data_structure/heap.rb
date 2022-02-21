# frozen_string_literal: true

module BinaryHeapDataStructure
  module Heap
    def initialize(*arguments, &block)
      @heap = []
      @block = block || heap_default_block

      push(*arguments)
    end

    def push(*items)
      items.each do |item|
        @heap.push(item)
        heapify_shiftup((@heap.size - 2) / 2)
      end

      self
    end

    def pop(num = nil)
      results = ::Array.new([(num || 1), @heap.size].min) do
        @heap[0], @heap[-1] = @heap[-1], @heap[0]
        result = @heap.pop
        heapify_shiftdown(0)
        result
      end

      return results[0] if num.nil?

      results
    end

    def first
      @heap.first
    end

    # def [](index)
    #   @heap[index]
    # end

    def size
      @heap.size
    end

    def pop_all
      pop(size)
    end

    def to_a
      dup.pop_all
    end

    private

    def heapify_shiftup(parent_index)
      return if parent_index.negative?

      child_index = heap_child_index(parent_index)
      return unless @block.call(@heap[child_index], @heap[parent_index])

      @heap[parent_index], @heap[child_index] = @heap[child_index], @heap[parent_index]

      heapify_shiftup((parent_index - 1) / 2)
    end

    def heapify_shiftdown(parent_index)
      child_index = heap_child_index(parent_index)
      return if child_index.nil?
      return unless @block.call(@heap[child_index], @heap[parent_index])

      @heap[parent_index], @heap[child_index] = @heap[child_index], @heap[parent_index]

      heapify_shiftdown(child_index)
    end

    def heap_child_index(parent_index)
      left_child_index = (parent_index * 2) + 1
      return nil if (@heap.size - 1) < left_child_index

      right_child_index = left_child_index + 1
      return left_child_index if (@heap.size - 1) < right_child_index

      if @block.call(@heap[left_child_index], @heap[right_child_index])
        left_child_index
      else
        right_child_index
      end
    end

    def heap_default_block
      proc do |a, b|
        a < b
      end
    end

    # dup時に呼ばれ、インスタンス変数をクローンする
    def initialize_copy(heap)
      @heap = heap.instance_variable_get(:@heap).dup
    end
  end
end

class Heap
  include BinaryHeapDataStructure::Heap
end
