# frozen_string_literal: true

module Lite
  module Redis
    class SortedSet < Lite::Redis::Base

      extend Lite::Redis::SortedSetHelper
      include Lite::Redis::SortedSetHelper

    end
  end
end
