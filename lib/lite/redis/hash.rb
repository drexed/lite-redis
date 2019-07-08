# frozen_string_literal: true

module Lite
  module Redis
    class Hash < Lite::Redis::Base

      extend Lite::Redis::HashHelper
      include Lite::Redis::HashHelper

    end
  end
end
