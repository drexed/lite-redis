# Lite::Redis

[![Gem Version](https://badge.fury.io/rb/lite-redis.svg)](http://badge.fury.io/rb/lite-redis)
[![Build Status](https://travis-ci.org/drexed/lite-redis.svg?branch=master)](https://travis-ci.org/drexed/lite-redis)

Lite::Redis is a library for accessing Redis with an ActiveRecord like ORM interface.

**NOTE:** If you are coming from `ActiveRedisDB`, please read the [port](#port) section.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'lite-redis'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install lite-redis

## Table of Contents

* [Configurations](#configurations)
* [Connections](#connections)
* [Commands](#commands)
* [Callers](#callers)
* [Port](#port)

## Configurations

`rails g lite:redis:install` will generate the following file:
`../config/initalizers/lite-redis.rb`

```ruby
Lite::Redis.configure do |config|
  config.client = Redis.new
end
```

## Connection pool

Use the [Connection Pool](https://github.com/mperham/connection_pool) gem to improve connection performance. Also look into [hiredis](https://github.com/redis/redis-rb#hiredis) driver to improve performance even further.

```ruby
Lite::Redis.configure do |config|
  config.client = ConnectionPool.new(size: 5, timeout: 5) { Redis.new }
end
```

## Commands

* [Connection](https://github.com/drexed/lite-redis/blob/master/docs/CONNECTION.md)
* [Geo](https://github.com/drexed/lite-redis/blob/master/docs/GEO.md)
* [Hash](https://github.com/drexed/lite-redis/blob/master/docs/HASH.md)
* [Hyper Log Log](https://github.com/drexed/lite-redis/blob/master/docs/HYPER_LOG_LOG.md)
* [Key](https://github.com/drexed/lite-redis/blob/master/docs/KEY.md)
* [List](https://github.com/drexed/lite-redis/blob/master/docs/LIST.md)
* [PubSub](https://github.com/drexed/lite-redis/blob/master/docs/PUB_SUB.md)
* [Script](https://github.com/drexed/lite-redis/blob/master/docs/SCRIPT.md)
* [Set](https://github.com/drexed/lite-redis/blob/master/docs/SET.md)
* [Sorted Set](https://github.com/drexed/lite-redis/blob/master/docs/SORTED_SET.md)
* [String](https://github.com/drexed/lite-redis/blob/master/docs/STRING.md)
* [Transaction](https://github.com/drexed/lite-redis/blob/master/docs/TRANSACTION.md)

## Call types

There are two ways to access Redis commands, single class and multiple instance access.
Multiple instance access reuses a Redis connection for better performance.

```ruby
# Single class access
Lite::Redis::String.create(:example, '123')
Lite::Redis::String.find(:example)

# - or -

# Multiple instance access
string = Lite::Redis::String.new
string.create(:example, '123')
string.find(:example)
```

## Port

`Lite::Redis` is a near compatible port of [ActiveRedisDB](https://github.com/drexed/active_redis_db).

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/lite-redis. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Lite::Redis project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/lite-redis/blob/master/CODE_OF_CONDUCT.md).
