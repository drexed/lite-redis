# frozen_string_literal: true

module Lite
  module Redis
    class Transaction < Lite::Redis::Base

      extend Lite::Redis::TransactionHelper
      include Lite::Redis::TransactionHelper

    end
  end
end
