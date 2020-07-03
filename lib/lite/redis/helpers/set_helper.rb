# frozen_string_literal: true

module Lite
  module Redis
    module SetHelper

      def find(key)
        client.smembers(key.to_s)
      end

      def combine(*args)
        client.sunion(*args)
      end

      def difference(*args)
        client.sdiff(*args)
      end

      def intersection(key, *args)
        client.sinter(key.to_s, *args)
      end

      def sample(key, value = 1)
        client.srandmember(key.to_s, value)
      end

      def value?(key, value)
        client.sismember(key.to_s, value)
      end

      def count(key)
        client.scard(key.to_s)
      end

      def create(key, args)
        client.sadd(key.to_s, args)
      end

      def create_combination(key, *args)
        client.sunionstore(key.to_s, *args)
      end

      def create_difference(key, *args)
        client.sdiffstore(key.to_s, *args)
      end

      def create_intersection(key, *args)
        client.sinterstore(key.to_s, *args)
      end

      def move(key, destination, value)
        client.smove(key.to_s, destination.to_s, value)
      end

      def destroy(key, args)
        client.srem(key.to_s, args)
      end

      def destroy_random(key)
        client.spop(key.to_s)
      end

      def scan(key, cursor, opts = {})
        client.sscan(key.to_s, cursor, **opts)
      end

    end
  end
end
