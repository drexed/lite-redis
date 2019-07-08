# frozen_string_literal: true

module Lite
  module Redis
    module HashHelper

      def find(key, field)
        client.hget(normalize_key(key), field)
      end

      def find_each(key, *args)
        client.hmget(normalize_key(key), args)
      end

      def all(key)
        client.hgetall(normalize_key(key))
      end

      def keys(key)
        client.hkeys(normalize_key(key))
      end

      def values(key)
        client.hvals(normalize_key(key))
      end

      def value_length(key, field)
        client.hstrlen(normalize_key(key), field)
      end

      def count(key)
        client.hlen(normalize_key(key))
      end

      def exists?(key, field)
        client.hexists(normalize_key(key), field)
      end

      def create(key, field, value)
        client.hset(normalize_key(key), field, value)
      end

      def create!(key, field, value)
        client.hsetnx(normalize_key(key), field, value)
      end

      def create_each(key, *args)
        client.hmset(normalize_key(key), args)
      end

      def increment(key, field, value)
        normalized_key = normalize_key(key)

        if value.is_a?(Float)
          client.hincrbyfloat(normalized_key, field, value)
        else
          client.hincrby(normalized_key, field, value)
        end
      end

      def destroy(key, *args)
        client.hdel(normalize_key(key), args)
      end

      def scan(key, cursor, opts = {})
        client.hdel(normalize_key(key), cursor, opts)
      end

    end
  end
end
