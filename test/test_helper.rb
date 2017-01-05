$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'acmesmith-http-path/version'
require 'acmesmith/command'

require 'minitest/autorun'

module Acmesmith
  class CommandTest < Acmesmith::Command

    desc "respond DOMAIN", "Do half the authz for DOMAIN."
    def respond(domain)
#      authz = acme.authorize(domain: domain)
#
#      challenges = [authz.http01, authz.dns01, authz.tls_sni01].compact
#
#      challenge = nil
#      responder = config.challenge_responders.find do |x|
#        challenge = challenges.find { |_| x.support?(_.class::CHALLENGE_TYPE) }
#      end

      responder, challenge = find_responder(domain)
      responder.respond(domain, challenge)
#     find_responder(domain).respond(domain, challenge)
    end

    desc "cleanup DOMAIN", "Do half the authz for DOMAIN."
    def cleanup(domain)
     responder, challenge = find_responder(domain)
     responder.cleanup(domain, challenge)
    end

    def find_responder(domain)
      authz = acme.authorize(domain: domain)

      challenges = [authz.http01, authz.dns01, authz.tls_sni01].compact

      challenge = nil
      responder = config.challenge_responders.find do |x|
        challenge = challenges.find { |_| x.support?(_.class::CHALLENGE_TYPE) }
      end

      [responder,challenge]
    end


  end
end
