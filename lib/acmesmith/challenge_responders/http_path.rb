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

        begin
          htdocs_path = @config[domain.to_sym]['htdocs_path']
        rescue
          raise "cannot read configuration for http_path"
        end

        puts "=> Responding challenge http-01 for #{domain} in #{self.class.name}"
        FileUtils.mkdir_p( File.join( htdocs_path, File.dirname( challenge.filename ) ) )
        File.write( File.join( htdocs_path, challenge.filename), challenge.file_content )
      end

      def cleanup(domain, challenge)
        raise NotImplementedError
      end

    end
  end
end
