Then /\bset the environment variables with "([^"]*)"$/ do | env |
  %w( GEMEDITOR VISUAL EDITOR ).each do | key |
    set_env(key, nil)
  end
  env.scan(/(\w+)=(\w+)/).each do | key, value |
    set_env(key, value)
  end
end
