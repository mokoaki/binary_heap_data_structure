# frozen_string_literal: true

module BinaryHeapDataStructure
  module Array
    def heap_sort(&block)
      dup.heap_sort!(&block)
    end

    def heap_sort!(&block)
      @block = block || heap_default_block

      heap_build
      heapify

      self
    end

    private

    def heap_build
      heap_limit = size - 1

      ((heap_limit - 1) / 2).downto(0) do |parent_index|
        heapify_shiftdown(parent_index, heap_limit)
      end
    end

    def heapify
      (size - 1).downto(1) do |heap_limit|
        self[0], self[heap_limit] = self[heap_limit], self[0]
        heapify_shiftdown(0, heap_limit - 1)
      end
    end

    def heapify_shiftdown(parent_index, heap_limit)
      child_index = heap_child_index(parent_index, heap_limit)
      return if child_index.nil?
      return unless @block.call(self[parent_index], self[child_index])

      self[parent_index], self[child_index] = self[child_index], self[parent_index]

      heapify_shiftdown(child_index, heap_limit)
    end

    def heap_child_index(parent_index, heap_limit)
      left_child_index = (parent_index * 2) + 1
      return nil if heap_limit < left_child_index

      right_child_index = left_child_index + 1
      return left_child_index if heap_limit < right_child_index

      if @block.call(self[left_child_index], self[right_child_index])
        right_child_index
      else
        left_child_index
      end
    end

    def heap_default_block
      proc do |a, b|
        a < b
      end
    end
  end
end

class Array
  include BinaryHeapDataStructure::Array
end
