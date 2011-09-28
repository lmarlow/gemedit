Feature: Output

  In order to fix command line problems
  As a developer using gemedit
  I want to see appropriate feedback in stderr or stdout

  Scenario: normal verbose output
    When I run `bundle exec gem edit gemedit --dry-run`
    Then the output should contain "Opening the gemedit gem"

  Scenario: unknown gem
    When I run `bundle exec gem edit unknowngemnotinstalledonthesystem`
    Then the stderr should contain "No gems found"

  Scenario: multiple gems
    When I run `bundle exec gem edit bundler gemedit`
    Then the stderr should contain "specify only one"

  Scenario: zero gems
    When I run `bundle exec gem edit`
    Then the stderr should contain "specify a gem name"
