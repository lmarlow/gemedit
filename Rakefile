require 'bundler'
Bundler::GemHelper.install_tasks

require 'rake/testtask'
Rake::TestTask.new do |t|
  t.libs << "test"
  t.test_files = FileList['test/**/*_test.rb']
  t.verbose = true
end

require 'cucumber/rake/task'
Cucumber::Rake::Task.new
task :cucumber => :install

task :default => [:test, :cucumber]
