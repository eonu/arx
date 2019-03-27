require 'bundler/gem_tasks'
require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new :spec

desc 'Run application specs'
task default: [:spec]

desc 'Debug the gem (load into IRB)'
task :debug do
  exec 'bundle exec rake install && irb -I lib/arx.rb -r arx'
end