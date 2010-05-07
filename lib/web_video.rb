require 'logger'

module WebVideo
  autoload :Tools, 'web_video/tools'
  autoload :Stream, 'web_video/stream'
  autoload :Transcoder, 'web_video/transcoder'
  
  module Adapters
    autoload :AbstractAdapter, 'web_video/adapters/abstract_adapter'
    autoload :FfmpegAdapter, 'web_video/adapters/ffmpeg_adapter'
  end

  #
  # WebVideo.logger.info 'Demo convert'
  #
  def self.logger
    @logger ||= Logger.new('/dev/null')      
    @logger
  end
  
  #
  # Configure logging. Pass a valid Ruby logger object.
  #
  #   logger = Logger.new(STDOUT)
  #   WebVideo.logger = logger
  #
  def self.logger=(value)
    @logger = value
  end
  
  class Error < StandardError #:nodoc:
  end

  class CommandLineError < StandardError #:nodoc:
  end
end
