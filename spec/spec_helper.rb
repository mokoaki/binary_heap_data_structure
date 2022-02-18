# frozen_string_literal: true

require "benchmark"
require_relative "../src/heap_object"
require_relative "../src/array_heap_sort"

RSpec.configure do |config|
  config.after(:suite) do
    puts "Ruby#{RUBY_VERSION}"

    COUNT = 50_000
    random_items = Array.new(COUNT) { rand(COUNT) }
    pushed_heap = Heap.new.push(*random_items)

    Benchmark.bm(20) do |x|
      target = Heap.new
      x.report("Heap  #push * n") do
        random_items.each { |item| target.push(item) }
      end

      target = Heap.new
      x.report("Heap  #push(*n)") do
        target.push(*random_items)
      end

      puts ""

      target = pushed_heap.dup
      x.report("Heap  #pop * n") do
        COUNT.times { target.pop }
      end

      target = pushed_heap.dup
      x.report("Heap  #pop(n)") do
        target.pop(COUNT)
      end

      target = pushed_heap.dup
      x.report("Heap  #pop_all") do
        target.pop_all
      end

      target = pushed_heap.dup
      x.report("Heap  #to_a") do
        target.to_a
      end

      puts ""

      target = random_items.dup
      x.report("Array #sort") do
        target.sort
      end

      target = random_items.dup
      x.report("Array #heap_sort") do
        target.heap_sort
      end

      target = random_items.dup
      x.report("Array #sort!") do
        target.sort!
      end

      target = random_items.dup
      x.report("Array #heap_sort!") do
        target.heap_sort!
      end

      puts ""

      target = random_items.dup
      x.report("Array min pop") do
        COUNT.times do
          target.delete_at(target.index(target.min))
        end
      end

      target = pushed_heap.dup
      x.report("Heap  min pop") do
        COUNT.times do
          target.pop
        end
      end

      puts ""

      target = []
      x.report("Array find min") do
        random_items.each do |item|
          target.push(item)
          target.min
        end
      end

      target = Heap.new
      x.report("Heap  find min") do
        random_items.each do |item|
          target.push(item)
          target.first
        end
      end
    end
  end
end
