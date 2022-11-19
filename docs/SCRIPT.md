# Script

## Usage

Please read the corresponding [class](https://github.com/drexed/lite-redis/blob/master/lib/lite/redis/script.rb) file to see all available methods.

Please read the corresponding [spec](https://github.com/drexed/lite-redis/blob/master/spec/lite/redis/script_spec.rb) file to see more example usages.

# Instance
```ruby
script = Lite::Redis::Script.new
script.eval('return #KEYS') #=> 0
```

#### Class
```ruby
Lite::Redis::Script.eval('return #KEYS') #=> 0
```
