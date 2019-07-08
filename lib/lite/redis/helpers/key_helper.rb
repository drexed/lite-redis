# frozen_string_literal: true

module Lite
  module Redis
    module KeyHelper

      def exists?(key)
        client.exists(stringify_key(key))
      end

      def type?(key)
        client.type(stringify_key(key))
      end

      def ttl?(key, format = :seconds)
        if seconds?(format)
          client.ttl(stringify_key(key))
        else
          client.pttl(stringify_key(key))
        end
      end

      def sort(key, opts = {})
        client.sort(stringify_key(key), opts)
      end

      def sample
        client.randomkey
      end

      def rename(key, value)
        client.rename(stringify_key(key), value.to_s)
      end

      def rename!(key, value)
        client.renamenx(stringify_key(key), value.to_s)
      end

      def destroy(key)
        client.del(stringify_key(key))
      end

      def persist(key)
        client.persist(stringify_key(key))
      end

      def expire(key, seconds, format = :seconds)
        if seconds?(format)
          client.expire(stringify_key(key), seconds)
        else
          client.pexpire(stringify_key(key), seconds)
        end
      end

      alias expire_in expire

      def expire_at(key, seconds, format = :seconds)
        if seconds?(format)
          client.expireat(stringify_key(key), seconds)
        else
          client.pexpireat(stringify_key(key), seconds)
        end
      end

      def dump(key)
        client.dump(stringify_key(key))
      end

      def match(pattern = '*')
        client.keys(stringify_key(pattern))
      end

      def migrate(key, options)
        client.migrate(stringify_key(key), options)
      end

      def move(key, destination)
        client.move(stringify_key(key), destination)
      end

      def object(*args)
        client.object(args)
      end

      def restore(key, milliseconds, value)
        client.restore(stringify_key(key), milliseconds, value)
      end

      def scan(cursor, opts = {})
        client.scan(cursor, opts)
      end

    end
  end
end
