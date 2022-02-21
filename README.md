# heap(データ構造)

```text
              0
      1               2
  3       4       5       6
7   8   9  10   11 12   13 14
```

- 要素の重み（優先度）の大小で親子関係を結ぶツリー構造
- 優先度が一番高い要素を最速でpopする、という用途なら彼の出番
- いわゆるメモリの「ヒープ領域」は別物
- 改良型ヒープ構造が多数存在する

## とりあえず基本的なバイナリヒープぽい動きをするオブジェクトを実装して遊ぶ

```ruby
require "./lib/binary_heap_data_structure/heap"

heap = Heap.new
heap.push(3)
heap.push(2).push(5)
heap.push(4, 6, 1)

heap.size
# => 6

heap.first
# => 1

heap.pop
# => 1
heap.pop(3)
# => [2, 3, 4]
heap.pop_all
# => [5, 6]
heap.pop
# => nil
```

```ruby
require "./lib/binary_heap_data_structure/heap"

heap = Heap.new(4, 3, 1)
heap.push(2)

heap.pop
# => 1
heap.pop(0)
# => []
heap.pop(1)
# => [2]
heap.pop(2)
# => [3, 4]
heap.pop
# => nil
heap.pop(0)
# => []
heap.pop(1)
# => []
```

```ruby
require "./lib/binary_heap_data_structure/heap"

heap = Heap.new { |a, b| a.size > b.size }
heap.push("aaaa")
heap.push("a", "aa")
heap.push("aaa")

heap.to_a
# => ["aaaa", "aaa", "aa", "a"]

heap.pop_all
# => ["aaaa", "aaa", "aa", "a"]

heap.pop
# => nil
```

## バイナリヒープソートを実装して遊ぶ

- バイナリヒープソートは安定ソートではない
- もっとも、Array#sort自体が安定ソートではない

```ruby
require "./lib/binary_heap_data_structure/array"

array = [3, 2, 5, 4, 6, 1]

array.heap_sort
# => [1, 2, 3, 4, 5, 6]
array
# => [3, 2, 5, 4, 6, 1]

array.heap_sort!
# => [1, 2, 3, 4, 5, 6]
array
# => [1, 2, 3, 4, 5, 6]
```

```ruby
require "./lib/binary_heap_data_structure/array"

array = ["faa", "eaa", "d", "ca", "b", "aa"]

array.heap_sort
# => ["aa", "b", "ca", "d", "eaa", "faa"]

array.heap_sort { |a, b| a > b }
# => ["faa", "eaa", "d", "ca", "b", "aa"]

array.heap_sort { |a, b| a.size < b.size }
# => ["b", "d", "aa", "ca", "eaa", "faa"]

array.heap_sort { |a, b| a.size > b.size }
# => ["eaa", "faa", "aa", "ca", "d", "b"]
```

## 実装してみてわかったこと

- ヒープの唯一の存在理由↓についてはヒープが早い、何十倍も早い( ･`ω･´)
  - 「優先順位が一番高い要素の参照はO(1)、popはO(log n)」
- ソート目的でArray#heap_sortを実装してもArray#sortの方が早い、何十倍も早い(´・ω・`)

## memo

```sh
bundle install
bundle exec rspec
```
