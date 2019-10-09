# frozen_string_literal: true

# ヒープ構造を作るオブジェクト
class Heap
  def initialize(*items, &block)
    @heap = []
    @block = block || default_block
    push(*items)
  end

  def push(*items)
    items.each.with_index(size - 1) do |item, pushed_index|
      @heap.push(item)
      heapify_up(pushed_index / 2)
    end

    self
  end

  def pop(count = 1)
    results = Array.new(count) do
      swap(0, -1)
      result = @heap.pop
      heapify_down(0)
      result
    end

    return results.first if results.size == 1

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

  def swap(index1, index2)
    @heap[index1], @heap[index2] = @heap[index2], @heap[index1]
  end

  def heapify_up(parent_index)
    return if parent_index.negative?

    child_index = target_child_index(parent_index)

    return unless @block.call(@heap[child_index], @heap[parent_index])

    swap(parent_index, child_index)
    heapify_up((parent_index - 1) / 2)
  end

  def heapify_down(parent_index)
    child_index = target_child_index(parent_index)

    return if child_index.nil?
    return unless @block.call(@heap[child_index], @heap[parent_index])

    swap(parent_index, child_index)
    heapify_down(child_index)
  end

  def target_child_index(parent_index)
    heap_limit = size - 1

    left_child_index = parent_index * 2 + 1
    return nil if heap_limit < left_child_index

    left_child_value = @heap[left_child_index]

    right_child_index = left_child_index + 1
    return left_child_index if heap_limit < right_child_index

    right_child_value = @heap[right_child_index]

    return left_child_index if @block.call(left_child_value, right_child_value)

    right_child_index
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
