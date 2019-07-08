# frozen_string_literal: true

require 'rails/railtie'

module Lite
  module Redis
    class Railtie < ::Rails::Railtie

      rake_tasks do
        path = File.expand_path('../../tasks/*.rake', __FILE__)
        Dir.each_child(path) { |filename| load(filename) }
      end

    end
  end
end
