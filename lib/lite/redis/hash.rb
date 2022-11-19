# frozen_string_literal: true

module Lite
  module Redis
    class Hash < Base

      def find(key, field)
        client.hget(key.to_s, field)
      end

      def find_each(key, *args)
        client.hmget(key.to_s, *args)
      end

      def all(key)
        client.hgetall(key.to_s)
      end

      def keys(key)
        client.hkeys(key.to_s)
      end

      def values(key)
        client.hvals(key.to_s)
      end

      def value_length(key, field)
        client.hstrlen(key.to_s, field)
      end

      def count(key)
        client.hlen(key.to_s)
      end

      def exists?(key, field)
        client.hexists(key.to_s, field)
      end

      def create(key, field, value)
        client.hset(key.to_s, field, value)
      end

      def create!(key, field, value)
        client.hsetnx(key.to_s, field, value)
      end

      def create_each(key, *args)
        client.hmset(key.to_s, *args)
      end

      def increment(key, field, value)
        if value.is_a?(Float)
          client.hincrbyfloat(key.to_s, field, value)
        else
          client.hincrby(key.to_s, field, value)
        end
      end

      def destroy(key, *args)
        client.hdel(key.to_s, *args)
      end

      def scan(key, cursor, opts = {})
        client.hdel(key.to_s, cursor, **opts)
      end

    end
  end
end
