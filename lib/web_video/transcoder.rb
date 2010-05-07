module WebVideo
  class Transcoder
    attr_accessor :source
    attr_reader :adapter

    # Video Convertation
    # 
    # transcoder = WebVideo::Transcoder.new("demo.avi")
    # transcoder.source # WebVideo::Adapters::AbstractAdapter instance
    #
    # Or
    #
    # video = WebVideo::Adapters::FfmpegAdapter.new('demo.avi')
    # transcoder = WebVideo::Transcoder.new(video)
    # transcoder.source # WebVideo::Adapters::FfmpegAdapter instance (video)
    #
    def initialize(filepath, options = {}, adapter = :ffmpeg)
      @adapter = adapter
      
      if filepath.is_a?(WebVideo::Adapters::AbstractAdapter)
        @source = filepath
      else
        args = [filepath, options]
        
        @source = case @adapter
          when String, Symbol then
            load_adapter(@adapter.to_s).new(*args)
          when Class then
            @adapter.new(*args)
          else
            @adapter
          end
        end
    end

    # Create screenshots
    #
    # transcoder = WebVideo::Transcoder.new("demo.avi")
    # transcoder.screenshot("demo.jpg", :resolution => "480x360")
    #
    # options:
    #   :count  - count images to generate
    #   :format - image decoder
    #   :at     - time to start make screenshots from
    #   :resolution - image resolution
    def screenshot(destination, options = {}, &block)
      options.symbolize_keys!
      
      options[:count] ||= 1
      options[:format] ||= "image2"
      options[:at] ||= "00:00:01"
      
      process(destination, @source.screenshot_command, options, &block)
    end

    # Generate new video file
    #
    # transcoder = WebVideo::Transcoder.new("demo.avi")
    #
    # begin
    #   transcoder.convert("demo.flv", :resolution => "480x360") do |command|
    #     command << "-ar 22050"
    #     command << "-ab 128k"
    #     command << "-acodec libmp3lame"
    #     command << "-vcodec flv"
    #     command << "-r 25"
    #     command << "-y"
    #   end
    #  rescue WebVideo::CommandLineError => e
    #    WebVideo.logger.error("Unable to transcode video: #{e.class} - #{e.message}")
    # end
    #
    # options:
    #   :resolution - video resolution
    #
    def convert(destination, options = {}, &block)
      options.symbolize_keys!
     
      process(destination, @source.convert_command, options, &block)
    end

    # Execute command
    #
    def execute(command, options = {})
      @source.run(command, options)
    end
    
    private
    
      def load_adapter(adapter_name)        
        class_name = "#{adapter_name}_adapter".classify
        "WebVideo::Adapters::#{class_name}".constantize
      end
      
      def process(destination, command, options = {}, &block)
        options[:input_file] = @source.filepath
        options[:output_file] = destination
        
        if block_given?
          begin
            yield command
          rescue Exception => e
            raise WebVideo::Error, "Error take screenshot #{destination}: #{e.class} => #{e.message}"
          end
        end
        
        command << "$output_file$"
      
        execute(command.join(' '), options)
      end
  end
end
