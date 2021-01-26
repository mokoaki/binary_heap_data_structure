# frozen_string_literal: true

require 'benchmark'
require_relative '../src/heap_object'
require_relative '../src/array_heap_sort'

RSpec.configure do |config|
  config.after(:suite) do
    puts "Ruby#{RUBY_VERSION}"

    COUNT = 50_000
    random_items = Array.new(COUNT) { rand(COUNT) }
    pushed_heap = Heap.new.push(*random_items)

    Benchmark.bm(20) do |x|
      target = Heap.new
      x.report('Heap #push * n') do
        random_items.each { |item| target.push(item) }
      end

      target = Heap.new
      x.report('Heap #push(*n)') do
        target.push(*random_items)
      end

      target = pushed_heap.dup
      x.report('Heap #pop * n') do
        COUNT.times { target.pop }
      end

      target = pushed_heap.dup
      x.report('Heap #pop_all') do
        target.pop_all
      end

      target = pushed_heap.dup
      x.report('Heap #to_a') do
        target.to_a
      end

      target = Heap.new
      x.report('Heap heap_sort') do
        target.push(*random_items)
        target.pop_all
      end

      target = random_items.dup
      x.report('Array #heap_sort') do
        target.heap_sort
      end

      target = random_items.dup
      x.report('Array #heap_sort!') do
        target.heap_sort!
      end

      target = random_items.dup
      x.report('Array #sort') do
        target.sort
      end

      target = random_items.dup
      x.report('Array #sort!') do
        target.sort!
      end

      target = random_items.dup
      x.report('Array min pop') do
        500.times do
          target.delete_at(target.index(target.min))
        end
      end

      target = pushed_heap.dup
      x.report('Heap pop') do
        500.times do
          target.push(rand(COUNT))
          target.pop
        end
      end

      target = []
      x.report('Array find min') do
        random_items[0, 3000].each do |item|
          target.push(item)
          target.min
        end
      end

      target = Heap.new
      x.report('Heap find min') do
        random_items[0, 3000].each do |item|
          target.push(item)
          target[0]
        end
      end
    end
  end
end
