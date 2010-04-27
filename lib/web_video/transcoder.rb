module WebVideo
  class Transcoder
    attr_accessor :source
    attr_reader :adapter
    
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
    
    # options:
    # *count - count images to generate
    # *format - image decoder
    # *at - time to start make screenshots from
    # *resolution - image resolution
    def screenshot(destination, options = {}, &block)
      options.symbolize_keys!
      
      options[:count] ||= 1
      options[:format] ||= "image2"
      options[:at] ||= "00:00:01"
      
      process(destination, @source.screenshot_command, options, &block)
    end
    
    # options:
    # *resolution - video resolution
    def convert(destination, options = {}, &block)
      options.symbolize_keys!
     
      process(destination, @source.convert_command, options, &block)
    end
    
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
