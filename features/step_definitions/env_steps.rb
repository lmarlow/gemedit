require 'gemedit'

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
