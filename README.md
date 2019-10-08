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

### 基本的なバイナリヒープぽい動きをするオブジェクトを実装して遊ぶ

```sh
gem update --system
gem update bundler
bundle install
bundle exec rspec
```

```sh
irb -r ./heap_object.rb
```

```ruby
heap = Heap.new
heap.push(2)
heap.push(3)
heap.push(1)
heap.push(4)

heap.pop
# => 1
heap.pop
# => 2
heap.to_a!
# => [3, 4]

Heap.new(9,2,8,3,7,4,7,-6,-8).to_a!
# => [-8, -6, 2, 3, 4, 7, 7, 8, 9]
```

### ヒープソートの実装
