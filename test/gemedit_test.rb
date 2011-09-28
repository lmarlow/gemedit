require 'test/unit'
require 'rubygems'
require 'gemedit'

class GemeditTest < Test::Unit::TestCase
  def test_gemedit_version
    assert_equal '1.0.1', Gemedit::Version
  end
end
