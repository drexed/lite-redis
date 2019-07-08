# frozen_string_literal: true

module Lite
  module Redis
    module PubSubHelper

      def publish(channel, message)
        client.publish(channel, message)
      end

      def subscribed?
        client.subscribed?
      end

      def subscribe(*channels, timeout: nil, &block)
        if timeout.nil?
          client.subscribe(*channels, &block)
        else
          client.subscribe_with_timeout(timeout, *channels, &block)
        end
      end

      def unsubscribe(*channels)
        client.unsubscribe(*channels)
      end

      def match_subscribe(*channels, timeout: nil, &block)
        if timeout.nil?
          client.psubscribe(*channels, &block)
        else
          client.psubscribe_with_timeout(timeout, *channels, &block)
        end
      end

      def match_unsubscribe(*channels)
        client.punsubscribe(*channels)
      end

      def state(command, *args)
        client.pubsub(command, *args)
      end

    end
  end
end
