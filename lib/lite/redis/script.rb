# frozen_string_literal: true

module Lite
  module Redis
    class Script < Lite::Redis::Base

      extend Lite::Redis::ScriptHelper
      include Lite::Redis::ScriptHelper

    end
  end
end
