# frozen_string_literal: true

# Arrayにheap_sortメソッドを追加する
class Array
  def heap_sort(&block)
    dup.heap_sort!(&block)
  end

  def heap_sort!(&block)
    block ||= default_block

    build_heep(block)
    heapify(block)

    self
  end

  private

  def build_heep(block)
    _size = size - 1

    ((_size - 1) / 2).downto(0) do |parent_index|
      heapify_down(parent_index, _size, block)
    end
  end

  def heapify(block)
    (size - 1).downto(1) do |heap_limit|
      self[0], self[heap_limit] = self[heap_limit], self[0]
      heapify_down(0, heap_limit - 1, block)
    end
  end

  def heapify_down(parent_index, heap_limit, block)
    child_index = target_child_index(parent_index, heap_limit, block)

    return if child_index.nil?

    parent_value = self[parent_index]
    child_value = self[child_index]

    return unless block.call(parent_value, child_value)

    self[parent_index] = child_value
    self[child_index] = parent_value

    heapify_down(child_index, heap_limit, block)
  end

  def target_child_index(parent_index, heap_limit, block)
    left_child_index = parent_index * 2 + 1

    return nil if heap_limit < left_child_index

    right_child_index = left_child_index + 1

    return left_child_index if heap_limit < right_child_index

    if block.call(self[left_child_index], self[right_child_index])
      right_child_index
    else
      left_child_index
    end
  end

  def default_block
    proc do |a, b|
      a < b
    end
  end
end
