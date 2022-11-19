# PubSub

## Usage

Please read the corresponding [class](https://github.com/drexed/lite-redis/blob/master/lib/lite/redis/pub_sub.rb) file to see all available methods.

Please read the corresponding [spec](https://github.com/drexed/lite-redis/blob/master/spec/lite/redis/pub_sub_spec.rb) file to see more example usages.

#### Instance
```ruby
pub_sub = Lite::Redis::PubSub.new
pub_sub.subscribe('foo') do |on|
  on.subscribe do |channel, total|
    @subscribed = true
    @t1 = total
  end

  on.message do |channel, message|
    if message == 's1'
      r.unsubscribe
      @message = message
    end
  end

  on.unsubscribe do |channel, total|
    @unsubscribed = true
    @t2 = total
  end
end
```

#### Class
```ruby
Lite::Redis::PubSub.subscribed? #=> true
```
