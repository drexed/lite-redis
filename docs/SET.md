# Set

#### Usage

Please read the corresponding [helper](https://github.com/drexed/lite-redis/blob/master/lib/lite/redis/helpers/set_helper.rb) file to see all available methods.

Please read the corresponding [spec](https://github.com/drexed/lite-redis/blob/master/spec/lite/redis/set_spec.rb) file to see more example usages.

```ruby
set = Lite::Redis::Set.new
set.create(:example, '1')       #=> 'OK'

Lite::Redis::Set.find(:example) #=> ['1']
```
