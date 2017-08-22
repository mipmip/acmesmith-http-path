require 'acmesmith/config'
require 'test_helper'

#require 'acmesmith/config'
#require 'acmesmith/command'
#require 'acmesmith/account_key'
#require 'acmesmith/certificate'

#require 'acme-client'

class AcmesmithHttpPathTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::AcmesmithHttpPath::VERSION
  end

  def before_setup
    super
    FileUtils.mkdir_p "/tmp/acmesmith-http-path_test/storage"
  end

  def after_teardown
    super
    FileUtils.rm_r "/tmp/acmesmith-http-path_test"
  end

  def test_if_responder_responds
    FileUtils.mkdir_p "/tmp/acmesmith-http-path_test/domain-one.com"

    args = ["register", "mailto:test@example.com", '-c', 'test/acmesmith-http-path/config.mock.yml']
    Acmesmith::CommandTest.start(args)

    args = ["respond", "domain-one.com", '-c', 'test/acmesmith-http-path/config.mock.yml']
    Acmesmith::CommandTest.start(args)

    newdir ='/tmp/acmesmith-http-path_test/domain-one.com/.well-known/acme-challenge/'
    assert(File.directory?(newdir))
  end

  def test_if_responder_cleans_up
    FileUtils.mkdir_p "/tmp/acmesmith-http-path_test/domain-one.com/.well-known/acme-challenge/"

    args = ["register", "mailto:test@example.com", '-c', 'test/acmesmith-http-path/config.mock.yml']
    Acmesmith::CommandTest.start(args)

    args = ["cleanup", "domain-one.com", '-c', 'test/acmesmith-http-path/config.mock.yml']
    Acmesmith::CommandTest.start(args)

    newdir ='/tmp/acmesmith-http-path_test/domain-one.com/.well-known/acme-challenge/'
    assert(!File.directory?(newdir))
  end

  def test_if_responder_uses_default_http_path_for_unconfigured_domain
    FileUtils.mkdir_p "/tmp/acmesmith-http-path_test"

    args = ["register", "mailto:test@example.com", '-c', 'test/acmesmith-http-path/config-with-default.mock.yml']
    Acmesmith::CommandTest.start(args)

    args = ["respond", "domain-two.com", '-c', 'test/acmesmith-http-path/config-with-default.mock.yml']
    Acmesmith::CommandTest.start(args)

    newdir ='/tmp/acmesmith-http-path_test/.well-known/acme-challenge/'
    assert(File.directory?(newdir))
  end
end
