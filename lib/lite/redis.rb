# frozen_string_literal: true

require 'redis'
require 'lite/redis/version'

%w[configuration].each do |file_name|
  require "lite/redis/#{file_name}"
end

require 'generators/lite/redis/install_generator'
