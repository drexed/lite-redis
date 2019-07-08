# frozen_string_literal: true

module Lite
  module Redis
    class HyperLogLog < Lite::Redis::Base

      extend Lite::Redis::HyperLogLogHelper
      include Lite::Redis::HyperLogLogHelper

    end
  end
end
