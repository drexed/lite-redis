# frozen_string_literal: true

module Lite
  module Redis
    module SetHelper

      def find(key)
        client.smembers(stringify_key(key))
      end

      def combine(*args)
        client.sunion(*args)
      end

      def difference(*args)
        client.sdiff(*args)
      end

      def intersection(key, *args)
        client.sinter(stringify_key(key), *args)
      end

      def sample(key, value = 1)
        client.srandmember(stringify_key(key), value)
      end

      def value?(key, value)
        client.sismember(stringify_key(key), value)
      end

      def count(key)
        client.scard(stringify_key(key))
      end

      def create(key, *args)
        client.sadd(stringify_key(key), args)
      end

      def create_combination(key, *args)
        client.sunionstore(stringify_key(key), args)
      end

      def create_difference(key, *args)
        client.sdiffstore(stringify_key(key), *args)
      end

      def create_intersection(key, *args)
        client.sinterstore(stringify_key(key), args)
      end

      def move(key, destination, value)
        client.smove(stringify_key(key), stringify_key(destination), value)
      end

      def destroy(key, *args)
        client.srem(stringify_key(key), *args)
      end

      def destroy_random(key)
        client.spop(stringify_key(key))
      end

      def scan(key, cursor, opts = {})
        client.sscan(stringify_key(key), cursor, opts)
      end

    end
  end
end
