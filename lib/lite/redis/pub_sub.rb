# frozen_string_literal: true

module Lite
  module Redis
    class PubSub < Lite::Redis::Base

      extend Lite::Redis::PubSubHelper
      include Lite::Redis::PubSubHelper

    end
  end
end
