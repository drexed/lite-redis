# Transaction

## Usage

Please read the corresponding [class](https://github.com/drexed/lite-redis/blob/master/lib/lite/redis/transaction.rb) file to see all available methods.

Please read the corresponding [spec](https://github.com/drexed/lite-redis/blob/master/spec/lite/redis/transaction_spec.rb) file to see more example usages.

#### Instance
```ruby
transaction = Lite::Redis::Transaction.new
transaction.discard #=> 'OK'
```

#### Class
```ruby
Lite::Redis::Transaction.discard #=> 'OK'
```
