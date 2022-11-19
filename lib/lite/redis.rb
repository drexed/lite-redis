# frozen_string_literal: true

require "generators/lite/redis/install_generator" if defined?(Rails::Generators)

require "lite/redis/railtie" if defined?(Rails::Railtie)
require "lite/redis/version"
require "lite/redis/configuration"
require "lite/redis/base"
require "lite/redis/connection"
require "lite/redis/geo"
require "lite/redis/hash"
require "lite/redis/hyper_log_log"
require "lite/redis/key"
require "lite/redis/list"
require "lite/redis/pub_sub"
require "lite/redis/script"
require "lite/redis/set"
require "lite/redis/sorted_set"
require "lite/redis/string"
require "lite/redis/transaction"
