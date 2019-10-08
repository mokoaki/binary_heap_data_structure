# frozen_string_literal: true

# ヒープ構造を作るオブジェクト
class Heap
  def initialize(*items, &block)
    @heap = []
    @block = block || default_block
    push(*items)
  end

  def push(*items)
    items.each do |item|
      @heap.push(item)
      heapify_up((size - 2) / 2)
    end

    self
  end

  def pop
    swap(0, -1)
    result = @heap.pop
    heapify_down(0)

    result
  end

  def size
    @heap.size
  end

  def to_a
    dup.to_a!
  end

  def to_a!
    Array.new(size) { pop }
  end

  private

  def target_child_index(parent_index)
    left_child_index = parent_index * 2 + 1
    return nil if (size - 1) < left_child_index

    left_child_value = @heap[left_child_index]

    right_child_index = left_child_index + 1
    return left_child_index if (size - 1) < right_child_index

    right_child_value = @heap[right_child_index]

    return left_child_index if @block.call(left_child_value, right_child_value)

    right_child_index
  end

  def swap(index1, index2)
    @heap[index1], @heap[index2] = @heap[index2], @heap[index1]
  end

  def heapify_up(parent_index)
    return if parent_index.negative?

    child_index = target_child_index(parent_index)

    return if @block.call(@heap[parent_index], @heap[child_index])

    swap(parent_index, child_index)
    heapify_up((parent_index - 1) / 2)
  end

  def heapify_down(parent_index)
    child_index = target_child_index(parent_index)

    return if child_index.nil?
    return if @block.call(@heap[parent_index], @heap[child_index])

    swap(parent_index, child_index)
    heapify_down(child_index)
  end

  def default_block
    proc do |a, b|
      a < b
    end
  end

  # dup時に呼ばれ、インスタンス変数をクローンする
  def initialize_copy(heap)
    @heap = heap.instance_variable_get(:@heap).dup
  end
end
