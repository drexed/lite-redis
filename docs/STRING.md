# String

#### Usage

Please read the corresponding [helper](https://github.com/drexed/lite-redis/blob/master/lib/lite/redis/helpers/string_helper.rb) file to see all available methods.

Please read the corresponding [spec](https://github.com/drexed/lite-redis/blob/master/spec/lite/redis/string_spec.rb) file to see more example usages.

```ruby
string = Lite::Redis::String.new
string.create(:example1, '123')     #=> 'OK'

Lite::Redis::String.find(:example1) #=> '123'
```
