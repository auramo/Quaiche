require 'net_source'
require 'file_source'
require 'next_time_extractor'
require 'bus_stop_source'
require 'timetable_service'
require 'global_settings'
require 'fileutils'
require 'logger'
require 'config'

class TimetableServiceInitializer
  def self.init_service
    FileUtils.mkdir_p AppFilesPath
    config = QConfig.get_config
    amount = get_config_arg("bus_amount", config)
    user = get_config_arg("user", config)
    pass = get_config_arg("pass", config)
    bus_stops = get_config_arg("bus_stops", config)
    data_sources = []
    bus_stops.each do |bus_stop, buses|
      extractor = NextTimeExtractor.new(amount, buses)
      data_sources << BusStopSource.new(bus_stop, amount,
                                        NetBusStopSource.new(bus_stop, extractor, user, pass),
                                        FileBusStopSource.new(bus_stop, extractor))
    end
    TimetableService.new(data_sources)
  end

  def self.get_config_arg(name, config)
    arg = config[name]
    raise ArgumentError.new("No #{name} configured") unless arg
    arg
  end
end
