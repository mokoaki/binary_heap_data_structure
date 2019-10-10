# heap(データ構造)

```text
              0
      1               2
  3       4       5       6
7   8   9  10   11 12   13 14
```

- いわゆる「ヒープ領域」は別物
- 他にも改良型のヒープが存在する
  - それらに関して、私は真に驚くべき証明を見つけたが、この余白はそれを書くには狭すぎる

## とりあえず基本的なバイナリヒープぽい動きをするオブジェクトを実装して遊ぶ

```sh
gem update --system
gem update bundler
bundle install
bundle exec rspec
```

```ruby
require './src/heap_object'

heap = Heap.new
heap.push(3)
heap.push(2).push(5)
heap.push(4, 6, 1)

heap.pop
# => 1
heap.pop(3)
# => [2, 3, 4]
heap.pop_all
# => [5, 6]
```

### ヒープソートの実装

ちょっと残念、安定ソートではない
