require File.expand_path("../lib/gemedit/version", __FILE__)

Gem::Specification.new do |s|
  s.name              = "gemedit"
  s.version           = Gemedit::Version
  s.date              = Time.now.strftime('%Y-%m-%d')
  s.summary           = "A utility to view a gem's source in your favorite editor"
  s.homepage          = "http://github.com/lmarlow/gemedit"
  s.email             = "lee.marlow@gmail.com"
  s.authors           = [ "Lee Marlow" ]
  s.has_rdoc          = false

  s.files             = %w( README.txt History.txt Rakefile License.txt )
  s.files            += Dir.glob("lib/**/*")
  #s.files            += Dir.glob("test/**/*")
  s.executables       = 'gemedit'
  s.require_path = 'lib'

  s.description       = <<desc
A utility to view a gem's source in your favorite editor
desc

  s.required_rubygems_version = ">= 1.3.6"
  s.rubyforge_project         = "gemedit"

  s.add_development_dependency "bundler",  "~> 1.0.0"
  s.add_development_dependency "rake",     "~> 0.8.7"
  s.add_development_dependency "cucumber", "~> 0.9.3"
  s.add_development_dependency "aruba",    "~> 0.2.3"
  s.add_development_dependency "rspec",    "~> 2.0.1"
end
