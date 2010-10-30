Feature: Output

  In order to open gems in my favorite editor
  As a developer using gemedit
  I want my editor started from the gem's directory

  Scenario: echoing pwd and editor args
    When I run "bundle exec gem edit bundler --editor='echo echo $(pwd)'"
    Then the output should contain "bundler"

  Scenario: echoing just the editor args
    When I run "bundle exec gem edit bundler --editor='echo echo'"
    Then the output should match /echo \.$/
