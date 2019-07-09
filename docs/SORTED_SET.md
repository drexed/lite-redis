# Sorted Set

#### Usage

Please read the corresponding [helper](https://github.com/drexed/lite-redis/blob/master/lib/lite/redis/helpers/sorted_set_helper.rb) file to see all available methods.

Please read the corresponding [spec](https://github.com/drexed/lite-redis/blob/master/spec/lite/redis/sorted_set_spec.rb) file to see more example usages.

```ruby
sorted_set = Lite::Redis::SortedSet.new
sorted_set.create(:example, 1, 1, 2, 'two', 3, '3') #=> 'OK'

Lite::Redis::SortedSet.find(:example, 2)            #=> 'two'
```
