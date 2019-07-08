# frozen_string_literal: true

module Lite
  module Redis
    module BaseHelper

      def client(new_client = nil)
        new_client || Lite::Redis.configuration.client
      end

      private

      def append?(order)
        stringify_key(order) == 'append'
      end

      def milliseconds?(format)
        stringify_key(format) == 'milliseconds'
      end

      def prepend?(order)
        stringify_key(order) == 'prepend'
      end

      def seconds?(format)
        stringify_key(format) == 'seconds'
      end

      def stringify_key(key)
        key.to_s
      end

      def stringify_keys(keys)
        keys.map { |key, _| stringify_key(key) }
      end

    end
  end
end
