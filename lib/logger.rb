require 'global_settings'

class Logger

  def self.info(msg)
    write_to_file("*INFO* " + msg)
  end

  def self.error(msg)
    write_to_file("*ERROR* " + msg)
  end

  def self.write_to_file(msg)
    File.open(LogFile, "a") do |log|
      log.puts(msg)
    end
  end
  
end





