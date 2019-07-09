# Script

#### Usage

Please read the corresponding [helper](https://github.com/drexed/lite-redis/blob/master/lib/lite/redis/helpers/script_helper.rb) file to see all available methods.

Please read the corresponding [spec](https://github.com/drexed/lite-redis/blob/master/spec/lite/redis/script_spec.rb) file to see more example usages.

```ruby
script = Lite::Redis::Script.new
script.script(:load, script)             #=> 'OK'

Lite::Redis::Script.eval('return #KEYS') #=> 0
```
