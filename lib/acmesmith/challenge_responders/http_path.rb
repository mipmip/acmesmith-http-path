require 'acmesmith/challenge_responders/base'

module Acmesmith
  module ChallengeResponders
    class HttpPath < Base

      def support?(type)
        type == 'http-01'
      end

      def initialize(config)
        @config = config
      end

      def respond(domain, challenge)
        cfpath = challenge_file_path domain, challenge 
        puts "=> Responding challenge http-01 for #{domain} in #{self.class.name}"
        FileUtils.mkdir_p File.dirname(cfpath)
        File.write(cfpath, challenge.file_content)
      end

      def cleanup(domain, challenge)
        cfpath = challenge_file_path domain, challenge 
        puts "=> Cleanup challenge http-01 for #{domain} in #{self.class.name}"
        File.unlink cfpath if File.exists? cfpath
      end

      def htdocs_path(domain)
        if @config[domain.to_sym] && @config[domain.to_sym]['htdocs_path']
          @config[domain.to_sym]['htdocs_path']
        elsif @config[:default] && @config[:default]['htdocs_path']
          @config[:default]['htdocs_path']
        else
          raise "cannot read configuration for http_path"
        end
      end

      def challenge_file_path(domain, challenge)
        File.join htdocs_path(domain), challenge.filename
      end

    end
  end
end
