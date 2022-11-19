# Geo

## Usage

Please read the corresponding [class](https://github.com/drexed/lite-redis/blob/master/lib/lite/redis/geo.rb) file to see all available methods.

Please read the corresponding [spec](https://github.com/drexed/lite-redis/blob/master/spec/lite/redis/geo_spec.rb) file to see more example usages.

#### Instance
```ruby
geo = Lite::Redis::Geo.new
geo.position('Sicily', 'Catania') #=> [['15.08726745843887329', '37.50266842333162032']]
```

#### Class
```ruby
Lite::Redis::Geo.position('Sicily', 'Catania') #=> [['15.08726745843887329', '37.50266842333162032']]
```
