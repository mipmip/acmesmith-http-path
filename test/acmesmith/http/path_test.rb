require 'test_helper'

class Acmesmith::Http::PathTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Acmesmith::Http::Path::VERSION
  end
end
