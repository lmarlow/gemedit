Feature: Editor

  In order to open gems in my favorite editor
  As a developer using gemedit
  I want to specify my editor

  Scenario Outline: editor preference
    When I set the environment variables with "<env>"
    When I run "bundle exec gem edit bundler <editor-arg> --dry-run"
    Then the output should contain "with <editor> from"

    Examples:
      | editor   | editor-arg     | env                                          |
      |  vi      |                |                                              |
      |  arged   | --editor=arged |                                              |
      |  arged   | -e arged       |                                              |
      |  mygemed |                | GEMEDITOR=mygemed                            |
      |  myvised |                | VISUAL=myvised                               |
      |  myed    |                | EDITOR=myed                                  |
      |  arged   | --editor=arged | GEMEDITOR=mygemed VISUAL=myvised EDITOR=myed |
      |  mygemed |                | GEMEDITOR=mygemed VISUAL=myvised EDITOR=myed |
      |  myvised |                | VISUAL=myvised EDITOR=myed                   |
