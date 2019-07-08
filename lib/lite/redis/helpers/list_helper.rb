# frozen_string_literal: true

module Lite
  module Redis
    module ListHelper

      def find(key, position = 1)
        client.lindex(stringify_key(key), position - 1)
      end

      def first(key, limit = 1)
        value = client.lrange(stringify_key(key), 0, -1)
        return value.first if limit == 1

        value.first(limit)
      end

      def last(key, limit = 1)
        value = client.lrange(stringify_key(key), 0, -1)
        return value.last if limit == 1

        value.last(limit)
      end

      def between(key, start = 1, finish = 0)
        client.lrange(stringify_key(key), start - 1, finish - 1)
      end

      def all(key)
        client.lrange(stringify_key(key), 0, -1)
      end

      def count(key)
        client.llen(stringify_key(key))
      end

      def create(key, value, order = :prepend)
        if append?(order)
          client.rpush(stringify_key(key), value)
        else
          client.lpush(stringify_key(key), value)
        end
      end

      def create!(key, value, order = :prepend)
        if append?(order)
          client.rpushx(stringify_key(key), value)
        else
          client.lpushx(stringify_key(key), value)
        end
      end

      def create_limit(key, value, limit, order = :prepend)
        if append?(order)
          client.rpush(stringify_key(key), value)
        else
          client.lpush(stringify_key(key), value)
        end

        client.ltrim(stringify_key(key), 0, limit - 1)
      end

      def create_limit!(key, value, limit, order = :prepend)
        if append?(order)
          client.rpushx(stringify_key(key), value)
        else
          client.lpushx(stringify_key(key), value)
        end

        client.ltrim(stringify_key(key), 0, limit - 1)
      end

      def create_before(key, pivot, value)
        client.linsert(stringify_key(key), :before, pivot, value)
      end

      def create_after(key, pivot, value)
        client.linsert(stringify_key(key), :after, pivot, value)
      end

      def update(key, index, value)
        client.lset(stringify_key(key), index, value)
      end

      def move(key, desination)
        client.rpoplpush(stringify_key(key), stringify_key(desination))
      end

      def move_blocking(key, desination)
        brpoplpush(stringify_key(key), stringify_key(desination))
      end

      def destroy(key, count, value)
        client.lrem(stringify_key(key), count, value)
      end

      def destroy_first(key, limit = 1)
        client.ltrim(stringify_key(key), limit, -1)
      end

      def destroy_last(key, limit = 1)
        client.ltrim(stringify_key(key), 0, -(limit + 1))
      end

      def destroy_except(key, start, finish)
        client.ltrim(stringify_key(key), start - 1, finish - 1)
      end

      def destroy_all(key)
        client.ltrim(stringify_key(key), -1, 0)
      end

      def pop(key, order = :prepend)
        if append?(order)
          client.rpop(key)
        else
          client.lpop(key)
        end
      end

      def pop_blocking(keys, opts = {})
        timeout = opts[:timeout] || 0

        if append?(opts[:order] || :prepend)
          client.brpop(keys, timeout)
        else
          client.blpop(keys, timeout)
        end
      end

    end
  end
end
