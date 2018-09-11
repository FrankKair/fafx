require 'bundler/gem_tasks'
require 'rspec/core/rake_task'
require 'fafx'

RSpec::Core::RakeTask.new(:spec)

task default: :spec

task :update_data do
  Fafx::ExchangeRate.fetch_data_and_save_to_disk
  puts 'Exchange rates data updated!'
end
