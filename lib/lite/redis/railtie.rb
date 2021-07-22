# frozen_string_literal: true

module Lite
  module Redis
    class Railtie < Rails::Railtie

      rake_tasks do
        file = File.expand_path('../../../tasks/redis.rake', __FILE__)
        load(file)
      end

    end
  end
end
