# Geo

#### Usage

Please read the corresponding [helper](https://github.com/drexed/lite-redis/blob/master/lib/lite/redis/helpers/geo_helper.rb) file to see all available methods.

Please read the corresponding [spec](https://github.com/drexed/lite-redis/blob/master/spec/lite/redis/geo_spec.rb) file to see more example usages.

```ruby
geo = Lite::Redis::Geo.new
geo.create('Sicily', 13.361389, 38.115556)      #=> 1

Lite::Redis::Geo.position('Sicily', 'Catania')  #=> [['15.08726745843887329', '37.50266842333162032']]
```
