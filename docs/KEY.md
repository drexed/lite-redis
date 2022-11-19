# Key

## Usage

Please read the corresponding [class](https://github.com/drexed/lite-redis/blob/master/lib/lite/redis/key.rb) file to see all available methods.

Please read the corresponding [spec](https://github.com/drexed/lite-redis/blob/master/spec/lite/redis/key_spec.rb) file to see more example usages.

#### Instance
```ruby
key = Lite::Redis::Key.new
key.exists?(:example) #=> true
```

#### Class
```ruby
Lite::Redis::Key.exists?(:example) #=> true
```
