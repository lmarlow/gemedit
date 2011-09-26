require 'gemedit'
require 'rubygems'

Then /\bset the environment variables with "([^"]*)"$/ do | env |
  keys_set = []
  env.scan(/(\w+)=(\w+)/).each do | key, value |
    keys_set << key
    set_env(key, value)
  end
  (Gem::Commands::EditCommand::EDITOR_ENV_VARS - keys_set).each do | key |
    set_env(key, nil)
  end
end

Before("@change_rubygems_version") do
  Gem.const_defined?("VERSION").should be_true
  @gem_version = Gem.const_get "VERSION"
end

Given /^I am using Rubygem version "([^"]*)"$/ do |version|
  Gem.const_set "VERSION", version
end

After("@change_rubygems_version") do
  Gem.const_set "VERSION", @gem_version
end