# frozen_string_literal: true

module Lite
  module Redis
    module StringHelper

      def find(key)
        client.get(normalize_key(key))
      end

      def find_each(*args)
        args = stringify_keys(args)
        client.mget(args)
      end

      def length(key)
        client.strlen(normalize_key(key))
      end

      def split(key, start, finish)
        client.getrange(normalize_key(key), start, finish)
      end

      def create(key, value, opts = {})
        client.set(normalize_key(key), value, opts)
      end

      def create!(key, value)
        client.setnx(normalize_key(key), value)
      end

      def create_each(*args)
        args = stringify_keys(args)
        client.mset(args)
      end

      def create_each!(*args)
        args = stringify_keys(args)
        client.msetnx(args)
      end

      def create_until(key, value, seconds, format = :seconds)
        if seconds?(format)
          client.setex(normalize_key(key), seconds, value)
        else
          client.psetex(normalize_key(key), seconds, value)
        end
      end

      def append(key, value)
        client.append(normalize_key(key), value)
      end

      def replace(key, value, offset)
        client.setrange(normalize_key(key), offset, value)
      end

      def decrement(key, value = 1)
        if value == 1
          client.decr(normalize_key(key))
        else
          client.decrby(normalize_key(key), value)
        end
      end

      def increment(key, value = 1)
        if value.is_a?(Float)
          client.incrbyfloat(normalize_key(key), value)
        elsif value == 1
          client.incr(normalize_key(key))
        else
          client.incrby(normalize_key(key), value)
        end
      end

      def reset(key, value = 0)
        client.getset(normalize_key(key), value)
      end

      def bit_count(key, start = 0, finish = -1)
        client.bitcount(normalize_key(key), start, finish)
      end

      def bit_where(operation, key, *keys)
        client.bitop(operation, key, *keys)
      end

      def get_bit(key, offset)
        client.getbit(normalize_key(key), offset)
      end

      def set_bit(key, offset, bit)
        client.setbit(normalize_key(key), offset, bit)
      end

    end
  end
end
