# frozen_string_literal: true

module Lite
  module Redis
    class Transaction < Base

      def discard
        client.discard
      end

      def exec
        client.exec
      end

      def multi(&block)
        client.multi(&block)
      end

      def watch(*args)
        client.watch(*args)
      end

      def unwatch
        client.unwatch
      end

    end
  end
end
