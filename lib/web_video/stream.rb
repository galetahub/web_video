module WebVideo
  class Stream
    attr_accessor :type, :codec, :details
    
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
    end
    
    def video?
      @type == 'video'
    end
    
    def audio?
      @type == 'audio'
    end
  end
end
