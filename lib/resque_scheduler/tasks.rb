# require 'resque/tasks'
# will give you the resque tasks

namespace :resque do
  task :setup

  desc "Start Resque Scheduler"
  task :scheduler => :scheduler_setup do
    gem 'resque-mongo'
    require 'resque'
    require 'resque_scheduler'

    Resque::Scheduler.verbose = true if ENV['VERBOSE']
    Resque::Scheduler.dynamic = true if ENV['DYNAMIC']
    Resque::Scheduler.run
  end

  task :scheduler_setup do
    if ENV['INITIALIZER_PATH']
      load ENV['INITIALIZER_PATH'].to_s.strip
    else
      Rake::Task['resque:setup'].invoke
    end
  end

end