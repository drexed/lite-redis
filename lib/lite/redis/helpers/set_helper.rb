# frozen_string_literal: true

module Lite
  module Redis
    module SetHelper

      def find(key)
        value = client.smembers(normalize_key(key))
      end

      def combine(*args)
        value = client.sunion(*args)
      end

      def difference(*args)
        value = client.sdiff(*args)
      end

      def intersection(key, *args)
        value = client.sinter(normalize_key(key), *args)
      end

      def sample(key, value = 1)
        value = client.srandmember(normalize_key(key), value)
      end

      def value?(key, value)
        client.sismember(normalize_key(key), value)
      end

      def count(key)
        client.scard(normalize_key(key))
      end

      def create(key, *args)
        client.sadd(normalize_key(key), args)
      end

      def create_combination(key, *args)
        client.sunionstore(normalize_key(key), args)
      end

      def create_difference(key, *args)
        client.sdiffstore(normalize_key(key), *args)
      end

      def create_intersection(key, *args)
        client.sinterstore(normalize_key(key), args)
      end

      def move(key, destination, value)
        client.smove(normalize_key(key), destination.to_s, value)
      end

      def destroy(key, *args)
        client.srem(normalize_key(key), *args)
      end

      def destroy_random(key)
        client.spop(normalize_key(key))
      end

      def scan(key, cursor, opts = {})
        client.sscan(normalize_key(key), cursor, opts)
      end

    end
  end
end
