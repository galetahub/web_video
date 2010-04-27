module WebVideo
  class Stream
    attr_accessor :type, :codec, :details
    # Stream.new :type => match[1], :codec => match[2], :details => match[3]
    def initialize(options = {})
      options.symbolize_keys!
      
      @type = options[:type]
      @codec = options[:codec]
      @details = options[:details]
    end
    
    def video?
      @type.downcase == 'video'
    end
    
    def audio?
      @type.downcase == 'audio'
    end
  end
end
