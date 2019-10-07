# heapの研究

- いわゆる「ヒープ領域」は別物
- 他にも改良型のヒープが存在する

## バイナリヒープ

### 基本的なヒープっぽい動きをするオブジェクトの実装

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
heap.push(3, 1, 2)
heap.pop
# => 1
heap.to_a
# => [2, 3]
heap.pop
# => [2, 3]
```

### ヒープソートの実装
