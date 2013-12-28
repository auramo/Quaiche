require 'global_settings'
require 'fileutils'

class Logger

  def self.info(msg)
    write_to_file("*INFO* " + Time.now.to_s + " " + msg)
  end

  def self.error(msg)
    write_to_file("*ERROR* " + Time.now.to_s + " " + msg)
  end

  def self.maybe_create_dir
    FileUtils.mkdir_p(AppFilesPath) unless File.exists?(AppFilesPath)
  end

  def self.write_to_file(msg)
    maybe_create_dir
    File.open(LogFile, "a") do |log|
      log.puts(msg)
    end
  end
  
end





