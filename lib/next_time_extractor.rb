require 'bus_data'

class NextTimeExtractor

  def initialize(amount, buses, time_class=Time)
    @amount = amount
    @buses = buses
    @time_class = time_class
  end

  def extract(bus_stop_timetable)
    curr_time = @time_class.new
    curr_minutes = to_minutes(curr_time)
    next_times = {}
    bus_stop_timetable.each do |bus, times|
      next unless @buses.include?(bus.name)
      next_bus_times = []
      times.each do |next_bus_time|
        next_bus_time_minutes = bus_time_to_minutes(curr_time, next_bus_time)
        next if next_bus_time_minutes < curr_minutes
        next_bus_times << NextBusTimes.new(next_bus_time_minutes - curr_minutes, next_bus_time)
        break if next_bus_times.length == @amount
      end
      next_times[bus] = next_bus_times
    end
    next_times
  end

  def bus_time_to_minutes(curr_time, bus_time)
    minutes = to_minutes(bus_time)
    if curr_time.hour > 21 and curr_time.hour <= 24 and bus_time.hour < 4
      minutes = minutes+24*60
    end
    minutes
  end
  
  def to_minutes(hour_min)
    hour_min.hour * 60 + hour_min.min
  end
end
