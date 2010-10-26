require 'bundler'
Bundler.setup
Bundler::GemHelper.install_tasks

require 'rake/testtask'
Rake::TestTask.new do |t|
  t.libs << 'lib'
  t.pattern = 'test/**/*_test.rb'
  t.verbose = false
end

require 'cucumber/rake/task'
Cucumber::Rake::Task.new
task :cucumber => :install

task :default => [:test, :cucumber]
