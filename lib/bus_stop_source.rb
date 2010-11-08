require 'logger'

class BusStopSource
  def initialize(bus_stop,
                 amount,
                 net_source,
                 file_source)
    @bus_stop = bus_stop
    @amount = amount
    @net_source = net_source
    @file_source = file_source
  end

  def get_times
    Logger.info("Fetching from file source for #{@bus_stop}")
    times = @file_source.get_times
    if inadequate(times)
      Logger.info("Cache for #{@bus_stop} old, fetching data from network")
      times, raw_data = @net_source.get_times
      @file_source.cache_raw(raw_data) unless inadequate(times)
    else
      Logger.info("Cached data up-to-date")
    end
    times
  end

  def inadequate(times)
    return true if times.length == 0
    times.each do |bus, times|
      return true if times.length < @amount
    end
    nil
  end
  
end
