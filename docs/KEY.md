# Key

#### Usage

Please read the corresponding [helper](https://github.com/drexed/lite-redis/blob/master/lib/lite/redis/helpers/key_helper.rb) file to see all available methods.

Please read the corresponding [spec](https://github.com/drexed/lite-redis/blob/master/spec/lite/redis/key_spec.rb) file to see more example usages.

```ruby
key = Lite::Redis::Key.new
key.create(:example, 'hello')      #=> 'OK'

Lite::Redis::Key.exists?(:example) #=> true
```
