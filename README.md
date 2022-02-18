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
require "./src/heap_object"

heap = Heap.new
heap.push(3)
heap.push(2).push(5)
heap.push(4, 6, 1)

heap.first
# => 1

heap.size
# => 7

heap.pop
# => [1]
heap.pop(3)
# => [2, 3, 4]
heap.pop_all
# => [5, 6]
heap.pop
# => nil
```

```ruby
require "./src/heap_object"

heap = Heap.new { |a, b| a.size < b.size }
heap.push("abcd")
heap.push("cd").push("abc")
heap.push("d", "ab", "bcdef")
heap.push("abc")

heap.to_a
# => ["d", "cd", "ab", "abc", "abc", "abcd", "bcdef"]

heap.pop(0)
# => []

heap.pop
# => ["d"]
heap.pop(3)
# => ["cd", "ab", "abc"]
heap.pop_all
# => ["abc", "abcd", "bcdef"]
heap.pop
# => nil

heap.pop(0)
# => nil
```

## バイナリヒープソートを実装して遊ぶ

- バイナリヒープソートは安定ソートではない
- もっとも、Array#sort自体が安定ソートではない

```ruby
require "./src/array_heap_sort"

items = [3, 2, 5, 4, 6, 1]

items.heap_sort
# => [1, 2, 3, 4, 5, 6]
items
# => [3, 2, 5, 4, 6, 1]

items.heap_sort!
# => [1, 2, 3, 4, 5, 6]
items
# => [1, 2, 3, 4, 5, 6]
```

```ruby
require "./src/array_heap_sort"

items = ["abc", "bc", "c", "cd", "a", "bcde", "ab"]

items.heap_sort
# => ["a", "ab", "abc", "bc", "bcde", "c", "cd"]

items.heap_sort { |a, b| a.size < b.size }
# => ["a", "c", "cd", "bc", "ab", "abc", "bcde"]

items.heap_sort { |a, b| a.size > b.size }
# => ["bcde", "abc", "cd", "bc", "ab", "a", "c"]

items
# => ["abc", "bc", "c", "cd", "a", "bcde", "ab"]

items.heap_sort! { |a, b| a.size < b.size }
# => ["a", "c", "cd", "bc", "ab", "abc", "bcde"]

items
# => ["a", "c", "cd", "bc", "ab", "abc", "bcde"]
```

## 実装してみてわかったこと

- ヒープの唯一の存在理由↓についてはヒープが早い、何十倍も早い( ･`ω･´)
  - 「優先順位が一番高い要素の参照はO(1)、popはO(log n)」
- ソート目的でArray#heap_sortを実装してもArray#sortの方が早い、何十倍も早い(´・ω・`)

## memo

```sh
gem update --system
bundle install
bundle exec rspec
```
