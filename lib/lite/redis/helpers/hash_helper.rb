# frozen_string_literal: true

module Lite
  module Redis
    module HashHelper

      def find(key, field)
        client.hget(stringify_key(key), field)
      end

      def find_each(key, *args)
        client.hmget(stringify_key(key), args)
      end

      def all(key)
        client.hgetall(stringify_key(key))
      end

      def keys(key)
        client.hkeys(stringify_key(key))
      end

      def values(key)
        client.hvals(stringify_key(key))
      end

      def value_length(key, field)
        client.hstrlen(stringify_key(key), field)
      end

      def count(key)
        client.hlen(stringify_key(key))
      end

      def exists?(key, field)
        client.hexists(stringify_key(key), field)
      end

      def create(key, field, value)
        client.hset(stringify_key(key), field, value)
      end

      def create!(key, field, value)
        client.hsetnx(stringify_key(key), field, value)
      end

      def create_each(key, *args)
        client.hmset(stringify_key(key), args)
      end

      def increment(key, field, value)
        if value.is_a?(Float)
          client.hincrbyfloat(stringify_key(key), field, value)
        else
          client.hincrby(stringify_key(key), field, value)
        end
      end

      def destroy(key, *args)
        client.hdel(stringify_key(key), args)
      end

      def scan(key, cursor, opts = {})
        client.hdel(stringify_key(key), cursor, opts)
      end

    end
  end
end
