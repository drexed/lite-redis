# frozen_string_literal: true

namespace :db do
  namespace :redis do
    desc 'Reset Redis database'
    task reset: :environment do
      puts '== Reset: reseting Redis '.ljust(80, '=')
      total_task_start_time = Time.current

      puts '  -> Resetting'
      Lite::Redis::Connection.flush

      total_task_elapsed_time = (Time.current - total_task_start_time).round(5)
      puts "== Reset: reset Redis (#{total_task_elapsed_time}s) ".ljust(80, '=')
      puts ''
    end

    desc 'Reset all Redis databases'
    task reset_all: :environment do
      puts '== Reset: reseting all Redis '.ljust(80, '=')
      total_task_start_time = Time.current

      puts '  -> Resetting'
      Lite::Redis::Connection.flush_all

      total_task_elapsed_time = (Time.current - total_task_start_time).round(5)
      puts "== Reset: reset all Redis (#{total_task_elapsed_time}s) ".ljust(80, '=')
      puts ''
    end
  end
end
