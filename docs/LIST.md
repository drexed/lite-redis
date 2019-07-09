# List

#### Usage

Please read the corresponding [helper](https://github.com/drexed/lite-redis/blob/master/lib/lite/redis/helpers/list_helper.rb) file to see all available methods.

Please read the corresponding [spec](https://github.com/drexed/lite-redis/blob/master/spec/lite/redis/list_spec.rb) file to see more example usages.

```ruby
list = Lite::Redis::List.new
list.create(:example, 'one')      #=> 'OK'

Lite::Redis::List.first(:example) #=> 'one'
```
