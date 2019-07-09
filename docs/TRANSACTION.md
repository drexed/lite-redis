# Transaction

#### Usage

Please read the corresponding [helper](https://github.com/drexed/lite-redis/blob/master/lib/lite/redis/helpers/transaction_helper.rb) file to see all available methods.

Please read the corresponding [spec](https://github.com/drexed/lite-redis/blob/master/spec/lite/redis/transaction_spec.rb) file to see more example usages.

```ruby
transaction = Lite::Redis::Transaction.new
transaction.multi { |m| m.set('foo', 's1') } #=> 'OK'

Lite::Redis::Transaction.discard             #=> 'OK'
```
