# HyperLogLog

#### Usage

Please read the corresponding [helper](https://github.com/drexed/lite-redis/blob/master/lib/lite/redis/helpers/hyper_log_log_helper.rb) file to see all available methods.

Please read the corresponding [spec](https://github.com/drexed/lite-redis/blob/master/spec/lite/redis/hyper_log_log_spec.rb) file to see more example usages.

```ruby
hyper_log_log = Lite::Redis::HyperLogLog.new
hyper_log_log.create(:foo, 's1')     #=> true

Lite::Redis::HyperLogLog.count(:foo) #=> 1
```
