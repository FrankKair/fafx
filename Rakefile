# frozen_string_literal: true

require 'bundler/gem_tasks'
require 'rspec/core/rake_task'
require 'fafx'

RSpec::Core::RakeTask.new(:spec)

task test: :spec
task default: :spec

task :update_data do
  Fafx::ExchangeRate.update_data
  puts 'Exchange rates data updated!'
end
