# frozen_string_literal: true

require 'redis' unless defined?(Redis)

require 'generators/lite/redis/install_generator' if defined?(Rails::Generators)

require 'lite/redis/railtie' if defined?(Rails::Railtie)
require 'lite/redis/version'
require 'lite/redis/configuration'

%w[
  base connection geo hash hyper_log_log key list pub_sub script set sorted_set string transaction
].each do |file_name|
  require "lite/redis/helpers/#{file_name}_helper"
  require "lite/redis/#{file_name}"
end
