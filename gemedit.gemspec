require File.expand_path("../lib/gemedit/version", __FILE__)

Gem::Specification.new do |s|
  s.name              = "gemedit"
  s.version           = Gemedit::Version
  s.date              = Time.now.strftime('%Y-%m-%d')
  s.summary           = "A utility to view a gem's source in your favorite editor"
  s.homepage          = "https://github.com/lmarlow/gemedit"
  s.email             = "lee.marlow@gmail.com"
  s.authors           = [ "Lee Marlow" ]
  s.has_rdoc          = false

  s.files             = %w( README.rdoc History.txt Rakefile License.txt )
  s.files            += Dir.glob("lib/**/*")
  s.require_path      = 'lib'

  s.description       = <<desc
A utility to view a gem's source in your favorite editor
desc

  s.required_rubygems_version = ">= 1.3.6"
  s.rubyforge_project         = "gemedit"

  s.add_development_dependency "bundler",  "~> 1.0.0"
  s.add_development_dependency "aruba",    "~> 0.3.2"
  s.add_development_dependency "rspec",    "~> 2.3.0"
  s.add_development_dependency "rake"
end
