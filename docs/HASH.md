# Hash

#### Usage

Please read the corresponding [helper](https://github.com/drexed/lite-redis/blob/master/lib/lite/redis/helpers/hash_helper.rb) file to see all available methods.

Please read the corresponding [spec](https://github.com/drexed/lite-redis/blob/master/spec/lite/redis/hash_spec.rb) file to see more example usages.

```ruby
hash = Lite::Redis::Hash.new
hash.create(:example, :name, 1)

Lite::Redis::Hash.find(:example, :name)  #=> 1
```
