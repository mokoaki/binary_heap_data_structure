# frozen_string_literal: true

class Array
  def heap_sort
    dup.heap_sort!
  end

  def heap_sort!
    ((self.size - 2) / 2).downto(0) do |parent_index|
      heapify_down(parent_index, self.size)
    end

    (self.size - 1).downto(1) do |heap_end|
      self[0], self[heap_end] = self[heap_end], self[0]
      heapify_down(0, heap_end)
    end

    self
  end

  private

  def heapify_down(parent_index, heap_end)
    child_index = target_child_index(parent_index, heap_end)

    return if child_index.nil?

    parent_value = self[parent_index]
    child_value = self[child_index]

    if child_value < parent_value
      self[parent_index] = child_value
      self[child_index] = parent_value
      heapify_down(child_index, heap_end)
    end
  end

  def target_child_index(parent_index, heap_end)
    left_child_index = parent_index * 2 + 1

    return nil if (heap_end - 1) < left_child_index

    left_child_value = self[left_child_index]

    right_child_index = left_child_index + 1
    return left_child_index if (heap_end - 1) < right_child_index

    right_child_value = self[right_child_index]

    return left_child_index if left_child_value < right_child_value

    right_child_index
  end
end

a =  Array.new(rand(5..15)) { rand(10) }.shuffle
p a.heap_sort
p a
p a.heap_sort!
p a
