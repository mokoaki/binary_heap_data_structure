# frozen_string_literal: true

# ヒープ構造を作るオブジェクト
class Heap
  def initialize(&block)
    @heap = []
    @block = block || default_block
  end

  def push(*items)
    heap = @heap
    block = @block

    items.each.with_index(size - 1) do |item, pushed_index|
      heap.push(item)
      heapify_up(heap, pushed_index / 2, heap.size - 1, block)
    end

    self
  end

  def pop(num = 1)
    heap = @heap
    block = @block

    results = Array.new([num, size].min) do
      swap(heap, 0, -1)
      result = heap.pop
      heapify_down(heap, 0, heap.size - 1, block)
      result
    end

    return results.first if num < 2

    results
  end

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

  def swap(heap, index1, index2)
    heap[index1], heap[index2] = heap[index2], heap[index1]
  end

  def heapify_up(heap, parent_index, heap_limit, block)
    return if parent_index.negative?

    child_index = target_child_index(heap, parent_index, heap_limit, block)

    return unless block.call(heap[child_index], heap[parent_index])

    swap(heap, parent_index, child_index)
    heapify_up(heap, (parent_index - 1) / 2, heap_limit, block)
  end

  def heapify_down(heap, parent_index, heap_limit, block)
    child_index = target_child_index(heap, parent_index, heap_limit, block)

    return if child_index.nil?
    return unless block.call(heap[child_index], heap[parent_index])

    swap(heap, parent_index, child_index)
    heapify_down(heap, child_index, heap_limit, block)
  end

  def target_child_index(heap, parent_index, heap_limit, block)
    left_child_index = parent_index * 2 + 1
    return nil if heap_limit < left_child_index

    right_child_index = left_child_index + 1
    return left_child_index if heap_limit < right_child_index

    if block.call(heap[left_child_index], heap[right_child_index])
      left_child_index
    else
      right_child_index
    end
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
