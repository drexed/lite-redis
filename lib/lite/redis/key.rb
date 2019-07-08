# frozen_string_literal: true

module Lite
  module Redis
    class Key < Lite::Redis::Base

      extend Lite::Redis::KeyHelper
      include Lite::Redis::KeyHelper

    end
  end
end
