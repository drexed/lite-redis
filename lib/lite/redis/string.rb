# frozen_string_literal: true

module Lite
  module Redis
    class String < Lite::Redis::Base

      extend Lite::Redis::StringHelper
      include Lite::Redis::StringHelper

    end
  end
end
