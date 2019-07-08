# frozen_string_literal: true

module Lite
  module Redis
    module ConnectionHelper

      def authenticate(password)
        client.auth(password)
      end

      def connected?
        client.connected?
      end

      def database(index)
        client.select(index)
      end

      def database_id
        client.database_id
      end

      def database_size
        client.dbsize
      end

      def debug(*args)
        client.debug(args)
      end

      def disconnect
        client.disconnect
      end

      def echo(message)
        client.echo(message)
      end

      def flush
        client.flushdb
      end

      def flush_all
        client.flushall
      end

      def info
        client.info
      end

      def ping
        client.ping
      end

      def quit
        client.quit
      end

      def reconnect
        client.reconnect
      end

      def rewrite_aof
        client.bgrewriteaof
      end

      def save
        client.bgsave
      end

      def saved_at
        client.lastsave
      end

      def shutdown
        client.shutdown
      end

      def slave_of(host, port)
        client.slaveof(host, port)
      end

      def slowlog(command, length = nil)
        client.slowlog(command, length)
      end

      def synchronize
        client.synchronize
      end

      def time
        client.time
      end

      def with_reconnect(&block)
        client.with_reconnect(true, &block)
      end

      def without_reconnect(&block)
        client.with_reconnect(false, &block)
      end

    end
  end
end
