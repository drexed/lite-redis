# Connection

#### Usage

Please read the corresponding [helper](https://github.com/drexed/lite-redis/blob/master/lib/lite/redis/helpers/connection_helper.rb) file to see all available methods.

Please read the corresponding [spec](https://github.com/drexed/lite-redis/blob/master/spec/lite/redis/connection_spec.rb) file to see more example usages.

```ruby
connection = Lite::Redis::Connection.new
connection.authenticate('pass')     #=> 'OK'

Lite::Redis::Connection.connected?  #=> true
```
