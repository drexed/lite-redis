# frozen_string_literal: true

module Lite
  module Redis
    class Connection < Lite::Redis::Base

      extend Lite::Redis::ConnectionHelper
      include Lite::Redis::ConnectionHelper

    end
  end
end
