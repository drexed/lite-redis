# frozen_string_literal: true

module Lite
  module Redis
    module StringHelper

      def find(key)
        client.get(key.to_s)
      end

      def find_each(*args)
        args = stringify_keys(*args)
        client.mget(args)
      end

      def length(key)
        client.strlen(key.to_s)
      end

      def split(key, start, finish)
        client.getrange(key.to_s, start, finish)
      end

      def create(key, value, opts = {})
        client.set(key.to_s, value, **opts)
      end

      def create!(key, value)
        client.setnx(key.to_s, value)
      end

      def create_each(*args)
        args = stringify_keys(*args)
        client.mset(args)
      end

      def create_each!(*args)
        args = stringify_keys(*args)
        client.msetnx(args)
      end

      def create_until(key, value, seconds, format = :seconds)
        if seconds?(format)
          client.setex(key.to_s, seconds, value)
        else
          client.psetex(key.to_s, seconds, value)
        end
      end

      def append(key, value)
        client.append(key.to_s, value)
      end

      def replace(key, value, offset)
        client.setrange(key.to_s, offset, value)
      end

      def decrement(key, value = 1)
        if value == 1
          client.decr(key.to_s)
        else
          client.decrby(key.to_s, value)
        end
      end

      def increment(key, value = 1)
        case value
        when Float then client.incrbyfloat(key.to_s, value)
        when 1 then client.incr(key.to_s)
        else client.incrby(key.to_s, value)
        end
      end

      def reset(key, value = 0)
        client.getset(key.to_s, value)
      end

      def bit_count(key, start = 0, finish = -1)
        client.bitcount(key.to_s, start, finish)
      end

      def bit_where(operation, key, *keys)
        client.bitop(operation, key, *keys)
      end

      def get_bit(key, offset)
        client.getbit(key.to_s, offset)
      end

      def set_bit(key, offset, bit)
        client.setbit(key.to_s, offset, bit)
      end

    end
  end
end
