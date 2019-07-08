# frozen_string_literal: true

Lite::Redis.configure do |config|
  config.client = Redis.new
end
