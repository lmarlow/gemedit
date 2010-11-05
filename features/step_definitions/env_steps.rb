Then /\bset the environment variables with "([^"]*)"$/ do | env |
  env.scan(/(\w+)=(\w+)/).each do | key, value |
    set_env(key, value)
  end
end
