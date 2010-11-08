require 'global_settings'
require 'logger'
require 'bus_stop_data_parser'

class FileBusStopSource
  def initialize(bus_stop, next_time_extractor)
    @bus_stop = bus_stop
    @cache_filename = AppFilesPath + @bus_stop + ".cache"
    @next_time_extractor = next_time_extractor
    @parser = BusStopDataParser.new
  end
  
  def get_times
    times = {}
    begin
      if cache_file_expired?
        Logger.info("Cache file expired for #{@bus_stop}")
        return times
      end
      raw = IO.read(@cache_filename)
      parsed = @parser.parse(raw)
      times = @next_time_extractor.extract(parsed)
      Logger.info("Cache found for bus stop #{@bus_stop}")
    rescue Errno::ENOENT
      Logger.info("No cache file #{@cache_filename} yet available")
    end
    times
  end

  def cache_file_expired?
    change_time = File.ctime(@cache_filename)
    diff = Time.now - change_time
    diff > 60*60*6
  end
  
  def cache_raw(raw)
    Logger.info("Storing cache to #{@cache_filename}")
    File.open(@cache_filename, "w") do |cache|
      cache.puts(raw)
    end
  end
  
end


