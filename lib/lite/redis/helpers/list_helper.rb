# frozen_string_literal: true

module Lite
  module Redis
    module ListHelper

      def find(key, position = 1)
        client.lindex(key.to_s, position - 1)
      end

      def first(key, limit = 1)
        value = client.lrange(key.to_s, 0, -1)
        return value.first if limit == 1

        value.first(limit)
      end

      def last(key, limit = 1)
        value = client.lrange(key.to_s, 0, -1)
        return value.last if limit == 1

        value.last(limit)
      end

      def between(key, start = 1, finish = 0)
        client.lrange(key.to_s, start - 1, finish - 1)
      end

      def all(key)
        client.lrange(key.to_s, 0, -1)
      end

      def count(key)
        client.llen(key.to_s)
      end

      def create(key, value, order = :prepend)
        if append?(order)
          client.rpush(key.to_s, value)
        else
          client.lpush(key.to_s, value)
        end
      end

      def create!(key, value, order = :prepend)
        if append?(order)
          client.rpushx(key.to_s, value)
        else
          client.lpushx(key.to_s, value)
        end
      end

      def create_limit(key, value, limit, order = :prepend)
        if append?(order)
          client.rpush(key.to_s, value)
        else
          client.lpush(key.to_s, value)
        end

        client.ltrim(key.to_s, 0, limit - 1)
      end

      def create_limit!(key, value, limit, order = :prepend)
        if append?(order)
          client.rpushx(key.to_s, value)
        else
          client.lpushx(key.to_s, value)
        end

        client.ltrim(key.to_s, 0, limit - 1)
      end

      def create_before(key, pivot, value)
        client.linsert(key.to_s, :before, pivot, value)
      end

      def create_after(key, pivot, value)
        client.linsert(key.to_s, :after, pivot, value)
      end

      def update(key, index, value)
        client.lset(key.to_s, index, value)
      end

      def move(key, desination)
        client.rpoplpush(key.to_s, desination.to_s)
      end

      def move_blocking(key, desination)
        brpoplpush(key.to_s, desination.to_s)
      end

      def destroy(key, count, value)
        client.lrem(key.to_s, count, value)
      end

      def destroy_first(key, limit = 1)
        client.ltrim(key.to_s, limit, -1)
      end

      def destroy_last(key, limit = 1)
        client.ltrim(key.to_s, 0, -(limit + 1))
      end

      def destroy_except(key, start, finish)
        client.ltrim(key.to_s, start - 1, finish - 1)
      end

      def destroy_all(key)
        client.ltrim(key.to_s, -1, 0)
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
