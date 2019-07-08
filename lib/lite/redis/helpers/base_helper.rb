# frozen_string_literal: true

module Lite
  module Redis
    module BaseHelper

      def client(new_client = nil)
        new_client || Lite::Redis.configuration.client
      end

      private

      def append?(order)
        normalize_key(order) == 'append'
      end

      def milliseconds?(format)
        normalize_key(format) == 'milliseconds'
      end

      def normalize_key(key)
        key.to_s
      end

      def prepend?(order)
        normalize_key(order) == 'prepend'
      end

      def seconds?(format)
        normalize_key(format) == 'seconds'
      end

      def stringify_keys(keys)
        keys.map { |key, _| normalize_key(key) }
      end

    end
  end
end
