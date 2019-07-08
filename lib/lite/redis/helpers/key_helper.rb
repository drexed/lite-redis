# frozen_string_literal: true

module Lite
  module Redis
    module KeyHelper

      def exists?(key)
      client.exists(normalize_key(key))
    end

    def type?(key)
      client.type(normalize_key(key))
    end

    def ttl?(key, format = :seconds)
      normalized_key = normalize_key(key)

      seconds?(format) ? client.ttl(normalized_key) : client.pttl(normalized_key)
    end

    def sort(key, opts = {})
      client.sort(normalize_key(key), opts)
    end

    def sample
      client.randomkey
    end

    def rename(key, value)
      client.rename(normalize_key(key), value.to_s)
    end

    def rename!(key, value)
      client.renamenx(normalize_key(key), value.to_s)
    end

    def destroy(key)
      client.del(normalize_key(key))
    end

    def persist(key)
      client.persist(normalize_key(key))
    end

    def expire(key, seconds, format = :seconds)
      normalized_key = normalize_key(key)

      if seconds?(format)
        client.expire(normalized_key, seconds)
      else
        client.pexpire(normalized_key, seconds)
      end
    end

    alias_method :expire_in, :expire

    def expire_at(key, seconds, format = :seconds)
      normalized_key = normalize_key(key)

      if seconds?(format)
        client.expireat(normalized_key, seconds)
      else
        client.pexpireat(normalized_key, seconds)
      end
    end

    def dump(key)
      client.dump(normalize_key(key))
    end

    def match(pattern = '*')
      value = client.keys(normalize_key(pattern))
      value = nil if value.empty?
      value
    end

    def migrate(key, options)
      client.migrate(normalize_key(key), options)
    end

    def move(key, destination)
      client.move(normalize_key(key), destination)
    end

    def object(*args)
      client.object(args)
    end

    def restore(key, milliseconds, value)
      client.restore(normalize_key(key), milliseconds, value)
    end

    def scan(cursor, opts = {})
      client.scan(cursor, opts)
    end

    end
  end
end
