# frozen_string_literal: true

module Lite
  module Redis
    module HyperLogLogHelper

      def create(key, member)
        client.pfadd(key.to_s, member)
      end

      def count(*args)
        client.pfcount(args)
      end

      def merge(key, *keys)
        client.pfmerge(key.to_s, keys)
      end

    end
  end
end
