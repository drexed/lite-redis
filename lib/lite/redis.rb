# frozen_string_literal: true

require 'redis'

require 'lite/redis/version'
require 'lite/redis/railtie' if defined?(Rails)
require 'lite/redis/configuration'

%w[
  base connection geo hash hyper_log_log key list pub_sub script set sorted_set string transaction
].each do |file_name|
  require "lite/redis/helpers/#{file_name}_helper"
  require "lite/redis/#{file_name}"
end

require 'generators/lite/redis/install_generator'
