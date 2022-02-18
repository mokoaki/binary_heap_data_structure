# frozen_string_literal: true

# ヒープ構造を保持するオブジェクト
class Heap
  def initialize(*arguments, &block)
    @heap = []
    @block = block || default_block

    arguments.each do |argument|
      push(argument)
    end
  end

  def push(*items)
    heap = @heap
    block = @block

    items.each.with_index(heap.size) do |item, pushed_index|
      heap.push(item)
      heapify_up(heap, (pushed_index - 1) / 2, pushed_index, block)
    end

    self
  end

  def pop(num = 1)
    heap = @heap
    block = @block

    results = Array.new([num, heap.size].min) do
      heap[0], heap[-1] = heap[-1], heap[0]
      result = heap.pop
      heapify_down(heap, 0, heap.size - 1, block)
      result
    end

    if results.empty? && heap.size == 0
      nil
    else
      results
    end
  end

  def first
    @heap[0]
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

  def heapify_up(heap, parent_index, heap_limit, block)
    return if parent_index.negative?

    child_index = target_child_index(heap, parent_index, heap_limit, block)

    parent_value = heap[parent_index]
    child_value = heap[child_index]

    return unless block.call(child_value, parent_value)

    heap[parent_index] = child_value
    heap[child_index] = parent_value

    heapify_up(heap, (parent_index - 1) / 2, heap_limit, block)
  end

  def heapify_down(heap, parent_index, heap_limit, block)
    child_index = target_child_index(heap, parent_index, heap_limit, block)

    return if child_index.nil?

    parent_value = heap[parent_index]
    child_value = heap[child_index]

    return unless block.call(child_value, parent_value)

    heap[parent_index] = child_value
    heap[child_index] = parent_value

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
