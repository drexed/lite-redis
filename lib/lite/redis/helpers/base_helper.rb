# frozen_string_literal: true

module Lite
  module Redis
    module BaseHelper

      attr_writer :client

      def initialize(redis = nil)
        @client = redis
      end

      def client
        @client ||= Lite::Redis.configuration.client
      end

      private

      def append?(order)
        order.to_s == 'append'
      end

      def milliseconds?(format)
        format.to_s == 'milliseconds'
      end

      def prepend?(order)
        order.to_s == 'prepend'
      end

      def seconds?(format)
        format.to_s == 'seconds'
      end

      def stringify_keys(*keys)
        keys.map { |key, _| key.to_s }
      end

    end
  end
end
