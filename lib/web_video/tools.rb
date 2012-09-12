require "subexec"

module WebVideo
  module Tools
    
    def self.run_with_option(command_name, params, options = {})
      run(command_name, apply_options(params, options))
    end

    #
    # Execute command with params and return output if exit status equal expected_outcodes
    #
    def self.run(cmd, params = "", expected_outcodes = 0)
      command = %Q[#{cmd} #{params}].gsub(/\s+/, " ")
      command = "#{command} 2>&1"
      
      WebVideo.logger.info(command)      
      
      sub = Subexec.run(command)
      
      unless Array.wrap(expected_outcodes).include?(sub.exitstatus)
        WebVideo.logger.info(sub.output)
        raise WebVideo::CommandLineError, "Error while running #{command}"
      end
      
      sub.output
    end
    
    def self.apply_options(command, options)
      str = command.dup
      
      options.each do |key, value|
        param = value.is_a?(String) ? value.inspect : value
        str.gsub!("$#{key}$", param.to_s)
      end
      
      str
    end
  end
end
