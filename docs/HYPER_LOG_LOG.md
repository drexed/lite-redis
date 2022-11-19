# HyperLogLog

## Usage

Please read the corresponding [class](https://github.com/drexed/lite-redis/blob/master/lib/lite/redis/hyper_log_log.rb) file to see all available methods.

Please read the corresponding [spec](https://github.com/drexed/lite-redis/blob/master/spec/lite/redis/hyper_log_log_spec.rb) file to see more example usages.

#### Instance
```ruby
hyper_log_log = Lite::Redis::HyperLogLog.new
hyper_log_log.count(:foo) #=> 1
```

#### Class
```ruby
Lite::Redis::HyperLogLog.count(:foo) #=> 1
```
