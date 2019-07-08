# frozen_string_literal: true

module Lite
  module Redis
    class Geo < Lite::Redis::Base

      extend Lite::Redis::GeoHelper
      include Lite::Redis::GeoHelper

    end
  end
end
