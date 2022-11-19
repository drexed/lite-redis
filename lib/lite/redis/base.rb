# frozen_string_literal: true

module Lite
  module Redis
    class Base

      attr_writer :client

      def initialize(redis = nil)
        @client = redis
      end

      class << self

        def method_missing(method_name, *args, **kwargs, &block)
          instance = new

          if instance.respond_to_method?(method_name)
            instance.send(method_name, *args, **kwargs, &block)
          else
            super
          end
        end

      end

      def client
        @client ||= Lite::Redis.configuration.client
      end

      def respond_to_method?(method_name)
        public_methods.include?(method_name)
      end

      def respond_to_missing?(method_name, include_private = false)
        respond_to_method?(method_name) || super
      end

      private

      def append?(order)
        order.to_s == "append"
      end

      def milliseconds?(format)
        format.to_s == "milliseconds"
      end

      def prepend?(order)
        order.to_s == "prepend"
      end

      def seconds?(format)
        format.to_s == "seconds"
      end

      def stringify_keys(*keys)
        keys.map { |key, _| key.to_s }
      end

    end
  end
end
