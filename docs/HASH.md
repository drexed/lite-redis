# Hash

## Usage

Please read the corresponding [class](https://github.com/drexed/lite-redis/blob/master/lib/lite/redis/hash.rb) file to see all available methods.

Please read the corresponding [spec](https://github.com/drexed/lite-redis/blob/master/spec/lite/redis/hash_spec.rb) file to see more example usages.

#### Instance
```ruby
hash = Lite::Redis::Hash.new
hash.find(:example, :name) #=> 1
```

#### Class
```ruby
Lite::Redis::Hash.find(:example, :name) #=> 1
```
