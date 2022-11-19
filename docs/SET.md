# Set

## Usage

Please read the corresponding [class](https://github.com/drexed/lite-redis/blob/master/lib/lite/redis/set.rb) file to see all available methods.

Please read the corresponding [spec](https://github.com/drexed/lite-redis/blob/master/spec/lite/redis/set_spec.rb) file to see more example usages.

#### Instance
```ruby
set = Lite::Redis::Set.new
set.find(:example) #=> ['1']
```

#### Class
```ruby
Lite::Redis::Set.find(:example) #=> ['1']
```
