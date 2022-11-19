# frozen_string_literal: true

module Lite
  module Redis
    module KeyHelper

      def exists?(key)
        client.exists(key.to_s)
      end

      def type?(key)
        client.type(key.to_s)
      end

      def ttl?(key, format = :seconds)
        if seconds?(format)
          client.ttl(key.to_s)
        else
          client.pttl(key.to_s)
        end
      end

      def sort(key, opts = {})
        client.sort(key.to_s, **opts)
      end

      def sample
        client.randomkey
      end

      def rename(key, value)
        client.rename(key.to_s, value.to_s)
      end

      def rename!(key, value)
        client.renamenx(key.to_s, value.to_s)
      end

      def destroy(key)
        client.del(key.to_s)
      end

      def persist(key)
        client.persist(key.to_s)
      end

      def expire(key, seconds, format = :seconds)
        if seconds?(format)
          client.expire(key.to_s, seconds)
        else
          client.pexpire(key.to_s, seconds)
        end
      end

      alias expire_in expire

      def expire_at(key, seconds, format = :seconds)
        if seconds?(format)
          client.expireat(key.to_s, seconds)
        else
          client.pexpireat(key.to_s, seconds)
        end
      end

      def dump(key)
        client.dump(key.to_s)
      end

      def match(pattern = "*")
        client.keys(pattern.to_s)
      end

      def migrate(key, options)
        client.migrate(key.to_s, options)
      end

      def move(key, destination)
        client.move(key.to_s, destination)
      end

      def object(*args)
        client.object(*args)
      end

      def restore(key, milliseconds, value)
        client.restore(key.to_s, milliseconds, value)
      end

      def scan(cursor, opts = {})
        client.scan(cursor, **opts)
      end

    end
  end
end
