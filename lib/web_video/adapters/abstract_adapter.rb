module WebVideo
  module Adapters
    class AbstractAdapter
      attr_accessor :filepath, :filename, :path
      
      def initialize(filepath, options = {})
        @filepath = filepath
        @filename = File.basename(@filepath)
        @path = File.dirname(@filepath)
        @options = options.symbolize_keys
        @metadata = parse
      end
      
      def file_exists?
        File.exist?(@filepath)
      end
      
      def size
        File.size(@filepath)
      end
      
      def duration
        @metadata[:duration]
      end
      
      def bitrate
        @metadata[:bitrate]
      end
      
      def streams
        @metadata[:streams]
      end
      
      def command_name
        ''
      end
      
      def convert_command
        []
      end
      
      def screenshot_command
        []
      end
      
      def installed?
        !WebVideo::Tools.run("which", command_name).blank?
      end
      
      def run(command, options = {})
        WebVideo::Tools.run_with_option(command_name, command, options)
      end
      
      private
        def parse
          return {}
        end
    end
  end
end
