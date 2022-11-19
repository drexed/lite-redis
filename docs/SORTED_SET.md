# Sorted Set

## Usage

Please read the corresponding [class](https://github.com/drexed/lite-redis/blob/master/lib/lite/redis/sorted_set.rb) file to see all available methods.

Please read the corresponding [spec](https://github.com/drexed/lite-redis/blob/master/spec/lite/redis/sorted_set_spec.rb) file to see more example usages.

#### Instance
```ruby
sorted_set = Lite::Redis::SortedSet.new
sorted_set.find(:example, 2)  #=> 'two'
```

#### Class
```ruby
Lite::Redis::SortedSet.find(:example, 2) #=> 'two'
```
