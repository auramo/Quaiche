require 'logger'
require 'yaml'

DefaultConfig = {
  "bus_amount" => 2,
  "bus_stops" => {"1223" => ["70T", "14", "14B"], "2041" => ["64", "66"]},
  "user" => "schmuser",
  "pass" => "hslbusstop"}

class QConfig
  def self.get_config
    config_data = nil
    begin
      config_data = read_data
    rescue Errno::ENOENT
      Logger.info("Configuration file #{UserConfigFile} not found, creating default configuration")
      File.open(UserConfigFile, "w") do |config_file|
        config_file.puts(YAML::dump(DefaultConfig))
      end
      config_data = read_data
    end
    YAML::load(config_data)
  end

  def self.read_data
    IO.read(UserConfigFile)
  end
  
end
