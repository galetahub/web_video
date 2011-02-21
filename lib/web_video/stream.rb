module WebVideo
  class Stream
    attr_accessor :type, :codec, :details, :resolution
    
    #
    # stream = Stream.new :type => 'Video', :codec => 'mpeg4', :details => 'yuv420p, 640x480 [PAR 1:1 DAR 4:3], 30 tbr, 30 tbn, 30 tbc'
    # stream.video? # => true
    # stream.audio? # => false 
    #
    def initialize(options = {})
      options.symbolize_keys!
      
      @type = options[:type].to_s.downcase
      @codec = options[:codec]
      @details = options[:details]
      @resolution = extract_resolution_from_details(@details)
    end
    
    def video?
      @type == 'video'
    end
    
    def audio?
      @type == 'audio'
    end
    
    def width
      @resolution ? @resolution[/^\d+/] : nil
    end
    
    def height
      @resolution ? @resolution[/\d+$/] : nil
    end
    
    private
      def extract_resolution_from_details(details)
        return nil if details.blank?
        
        details[/\s\d+x\d+\s/].strip 
      end
  end
end
