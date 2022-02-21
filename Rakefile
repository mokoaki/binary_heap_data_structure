# frozen_string_literal: true

require "bundler/gem_tasks"
# require "rspec/core/rake_task"

# RSpec::Core::RakeTask.new(:spec)

# task default: :spec

task :benchmark do
  require "benchmark"
  require "binary_heap_data_structure"

  puts "Ruby #{RUBY_VERSION}"

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

    target = pushed_heap.dup
    x.report("Heap  #pop * n") do
      COUNT.times { target.pop }
    end

    target = pushed_heap.dup
    x.report("Heap  #pop(n)") do
      target.pop(COUNT)
    end

    puts ""

    target = random_items.dup
    x.report("Array #sort!") do
      target.sort!
    end

    target = random_items.dup
    x.report("Array #heap_sort!") do
      target.heap_sort!
    end

    puts ""

    target = random_items.dup.sort
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
