# frozen_string_literal: true

require "redis" unless defined?(Redis)

module Lite
  module Redis

    class Configuration

      attr_accessor :client

      def initialize
        @client = ::Redis.new
      end

    end

    class << self

      attr_writer :configuration

      def configuration
        @configuration ||= Configuration.new
      end

      def configure
        yield(configuration)
      end

      def reset_configuration!
        @configuration = Configuration.new
      end

    end

  end
end
