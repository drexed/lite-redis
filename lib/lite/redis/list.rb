# frozen_string_literal: true

module Lite
  module Redis
    class List < Lite::Redis::Base

      extend Lite::Redis::ListHelper
      include Lite::Redis::ListHelper

    end
  end
end
