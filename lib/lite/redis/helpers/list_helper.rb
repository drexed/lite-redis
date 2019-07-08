# frozen_string_literal: true

module Lite
  module Redis
    module ListHelper

      def find(key, position = 1)
        value = client.lindex(normalize_key(key), (position - 1))

        value
      end

      def first(key, limit = 1)
        value = client.lrange(normalize_key(key), 0, -1)
        value = (limit == 1 ? value.first : value.first(limit))

        value
      end

      def last(key, limit = 1)
        value = client.lrange(normalize_key(key), 0, -1)
        value = (limit == 1 ? value.last : value.last(limit))

        value
      end

      def between(key, start = 1, finish = 0)
        value = client.lrange(normalize_key(key), (start - 1), (finish - 1))
          end

      def all(key)
        value = client.lrange(normalize_key(key), 0, -1)
          end

      def count(key)
        client.llen(normalize_key(key))
      end

      def create(key, value, order = :prepend)
        normalized_key = normalize_key(key)

        append?(order) ? client.rpush(normalized_key, value) : client.lpush(normalized_key, value)
      end

      def create!(key, value, order = :prepend)
        normalized_key = normalize_key(key)

        append?(order) ? client.rpushx(normalized_key, value) : client.lpushx(normalized_key, value)
      end

      def create_limit(key, value, limit, order = :prepend)
        normalized_key = normalize_key(key)

        append?(order) ? client.rpush(normalized_key, value) : client.lpush(normalized_key, value)
        client.ltrim(normalized_key, 0, (limit - 1))
      end

      def create_limit!(key, value, limit, order = :prepend)
        normalized_key = normalize_key(key)

        append?(order) ? client.rpushx(normalized_key, value) : client.lpushx(normalized_key, value)
        client.ltrim(normalized_key, 0, (limit - 1))
      end

      def create_before(key, pivot, value)
        client.linsert(normalize_key(key), :before, pivot, value)
      end

      def create_after(key, pivot, value)
        client.linsert(normalize_key(key), :after, pivot, value)
      end

      def update(key, index, value)
        client.lset(normalize_key(key), index, value)
      end

      def move(key, desination)
        value = client.rpoplpush(normalize_key(key), normalize_key(desination))

        value
      end

      def move_blocking(key, desination)
        value = brpoplpush(normalize_key(key), normalize_key(desination))

        value
      end

      def destroy(key, count, value)
        client.lrem(normalize_key(key), count, value)
      end

      def destroy_first(key, limit = 1)
        client.ltrim(normalize_key(key), limit, -1)
      end

      def destroy_last(key, limit = 1)
        client.ltrim(normalize_key(key), 0, -(limit + 1))
      end

      def destroy_except(key, start, finish)
        client.ltrim(normalize_key(key), (start - 1), (finish - 1))
      end

      def destroy_all(key)
        client.ltrim(normalize_key(key), -1, 0)
      end

      def pop(key, order = :prepend)
        value = append?(order) ? client.rpop(key) : client.lpop(key)

        value
      end

      def pop_blocking(keys, opts = {})
        timeout = opts[:timeout] || 0
        value = if append?(opts[:order] || :prepend)
                  client.brpop(keys, timeout)
                else
                  client.blpop(keys, timeout)
                end

        value
      end

    end
  end
end
