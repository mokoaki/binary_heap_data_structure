# heap(データ構造)

```text
            0
     1             2
  3      4      5      6
7   8  9  10  11 12  13 14
```

- いわゆる「ヒープ領域」は別物
- 他にも改良型のヒープが存在する
- それらに関して、私は真に驚くべき証明を見つけたが、この余白はそれを書くには狭すぎる

## とりあえずバイナリヒープ

ちょっと残念、安定ソートではない

### 基本的なバイナリヒープぽい動きをするオブジェクトを実装して遊ぶ

```sh
gem update --system
gem update bundler
bundle install
bundle exec rspec
```

```sh
bundle exec pry -r './src/heap_object.rb'
```

```ruby
heap = Heap.new(7, 2)
heap.push(6)
heap.push(3).push(5)
heap.push(4, 1)

heap.pop
# => 1
heap.pop
# => 2
heap.to_a
# => [3, 4, 5, 6, 7]
```

### ヒープソートの実装
