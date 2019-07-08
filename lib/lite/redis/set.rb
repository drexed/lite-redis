# frozen_string_literal: true

module Lite
  module Redis
    class Set < Lite::Redis::Base

      extend Lite::Redis::SetHelper
      include Lite::Redis::SetHelper

    end
  end
end
