require "acmesmith/challenge_responders/base"

module Acmesmith
  module ChallengeResponders
    class HttpPath < Base
      def support?(type)
        type == 'http-01'
      end

      def initialize(config)
        @config = config
        @htdocs_path = @config[:htdocs_path]
      end

      def respond(domain, challenge)
        puts "=> Responding challenge http-01 for #{domain} in #{self.class.name}"
        FileUtils.mkdir_p( File.join( @htdocs_path, File.dirname( challenge.filename ) ) )
        File.write( File.join( @htdocs_path, challenge.filename), challenge.file_content )

        raise NotImplementedError
      end

      def cleanup(domain, challenge)
        raise NotImplementedError
      end

    end
  end
end
