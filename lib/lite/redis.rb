# frozen_string_literal: true

require 'redis' unless defined?(Redis)

require 'generators/lite/redis/install_generator' if defined?(Rails::Generators)

require 'lite/redis/railtie' if defined?(Rails::Railtie)
require 'lite/redis/version'
require 'lite/redis/configuration'
require 'lite/redis/helpers/base_helper'
require 'lite/redis/helpers/connection_helper'
require 'lite/redis/helpers/geo_helper'
require 'lite/redis/helpers/hash_helper'
require 'lite/redis/helpers/hyper_log_log_helper'
require 'lite/redis/helpers/key_helper'
require 'lite/redis/helpers/list_helper'
require 'lite/redis/helpers/pub_sub_helper'
require 'lite/redis/helpers/script_helper'
require 'lite/redis/helpers/set_helper'
require 'lite/redis/helpers/sorted_set_helper'
require 'lite/redis/helpers/string_helper'
require 'lite/redis/helpers/transaction_helper'
require 'lite/redis/base'
require 'lite/redis/connection'
require 'lite/redis/geo'
require 'lite/redis/hash'
require 'lite/redis/hyper_log_log'
require 'lite/redis/key'
require 'lite/redis/list'
require 'lite/redis/pub_sub'
require 'lite/redis/script'
require 'lite/redis/set'
require 'lite/redis/sorted_set'
require 'lite/redis/string'
require 'lite/redis/transaction'
