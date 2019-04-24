require 'thor'
require 'bundler/gem_tasks'
require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new :spec

desc 'Run application specs'
task default: [:spec]

namespace :gem do
  class T < Thor
    include Thor::Actions
  end

  desc 'Debug the gem (load into IRB)'
  task :debug do
    exec 'bin/console'
  end

  desc 'Prepare a new gem release'
  task :release, %i[major minor patch meta] do |task, args|
    array = args.to_a
    raise ArgumentError.new("Expected at least 3 SemVer segments, got #{array.size}") if array.size < 3
    raise ArgumentError.new("Expected no more than 4 SemVer segments, got #{array.size}") if array.size > 4
    args.to_h.each_with_index do |(segment, value), index|
      next if index == array.size - 1 && array.size == 4
      raise TypeError.new("Invalid #{segment} SemVer segment: #{value}") unless value == value.to_i.to_s
    end

    versions = args.to_h.transform_values {|v| v.to_i if Integer(v) rescue v}
    versions[:meta] ||= nil
    update_version versions

    version = versions.compact.values.join('.')
    add_changelog_entry version
  end

  private

  def update_version(versions)
    versions.each do |segment, value|
      thor :gsub_file, File.join(__dir__, 'lib', 'arx', 'version.rb'), /#{segment}: .*,/, "#{segment}: #{value.inspect},"
    end
  end

  def add_changelog_entry(version)
    thor :insert_into_file, File.join(__dir__, 'CHANGELOG.md'), after: /\A/ do
      <<-ENTRY
# #{version}

#### Major changes

- TODO

#### Minor changes

- TODO

      ENTRY
    end
  end

  def thor(*args, &block)
    T.new.send *args, &block
  end
end