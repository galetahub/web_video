module WebVideo
  module Adapters
    class FfmpegAdapter < AbstractAdapter
      
      # 00:21:41.18
      def duration_in_seconds
        if @metadata[:duration] =~ /(\d+)\:(\d+)\:(\d+)\.(\d+)/
          ( $1.to_i * 60 * 60 ) + ( $2.to_i * 60 ) + ( $3.to_i ) + ( ($4.to_i/100) * 60 )
        else
          0
        end
      end
      
      def command_name
        'ffmpeg'
      end
      
      def convert_command
        command = []
        command << "-i $input_file$"
        command << "-s $resolution$"
        
        command.dup
      end
      
      def screenshot_command
        command = []
        command << "-i $input_file$"
    
        # Specifies the frame size of the output (Default is the size of the original video.)
        command << "-s $resolution$"
        
        # Frame rate of video. i.e. no. of frames to be extracted into images per second
        # The default value is 25
        command << "-r 1"
        
        # Disable audio recording.
        command << "-an"
        
        # Number of video frames to record
        command << "-vframes $count$"
        
        # Force format (image2|rawvideo)
        command << "-f $format$"
        
        # Start the extraction from particular point
        command << "-ss $at$"
        
        command.dup
      end
      
      private
        def parse
          if installed?
            metadata = { :streams => [] }
            
            ffmpeg_output = WebVideo::Tools.run(command_name, "-i #{@filepath.inspect}", [0,1])
            
            metadata[:duration] = $1 if ffmpeg_output =~ /Duration\:\s+(\d+\:\d+\:\d+\.\d+)\,/i
            metadata[:bitrate] = $1 if ffmpeg_output =~ /\,\s+bitrate\:\s+(.*)$/i
            
            ffmpeg_output.scan(/Stream\s+#0.(\d+)(\[.+\])?(\(.+\))?:\s(.*):\s([^,]*),\s(.*)/i).each do |match|
              metadata[:streams] << WebVideo::Stream.new(:type => match[3], :codec => match[4], :details => match[5])
            end
            
            return metadata
          end
        end
    end
  end
end
