Feature: exit statuses

  In order to specify expected exit statuses
  As a developer using gemedit
  I want the gem edit command to exit with appropriate status

  Scenario: exit status of 0
    When I run `bundle exec gem edit gemedit --dry-run`
    Then the exit status should be 0

  Scenario: non-zero exit status for unknown gem
    When I run `bundle exec gem edit unknowngemnotinstalledonthesystem`
    Then the exit status should not be 0

  Scenario: non-zero exit status for multiple gems
    When I run `bundle exec gem edit bundler gemedit`
    Then the exit status should not be 0

  Scenario: non-zero exit status for zero gems
    When I run `bundle exec gem edit`
    Then the exit status should not be 0
