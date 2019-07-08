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

      def subscribe(*channels, &block)
        client.subscribe(channels, &block)
      end

      def unsubscribe(*channels)
        client.unsubscribe(channels)
      end

      def match_subscribe(*channels, &block)
        client.psubscribe(channels, &block)
      end

      def match_unsubscribe(*channels)
        client.punsubscribe(channels)
      end

      def state(command, *args)
        client.pubsub(command, args)
      end

    end
  end
end
