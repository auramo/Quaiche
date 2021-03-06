require 'bus_data'
require 'rubygems'
require 'json'

class BusStopDataJsonParser
  def parse(data)
    parsed = JSON.parse(data)
    return {} if parsed.length == 0
    result = {}
    parsed.each do | stop_info |
      line_directions = parse_directions(stop_info)
      departures = parse_departures(stop_info)

      departures.each do | departure |
        bus_id = departure["busId"]
        time = departure["time"]
        direction = line_directions[bus_id]
        bus = BusWithDirection.new(bus_id, direction)
        add_departure(result, bus, time)
      end
    end
    result
  end

  def add_departure(parsed, busId, time)
    if not parsed.key?(busId)
      parsed[busId] = []
    end
    parsed[busId] << time
    parsed
  end
  
  def parse_departures(stop_info)
    raw_departures = stop_info["departures"]
    departures = raw_departures.map do | departure |
      raw_code = departure["code"]
      raw_time = departure["time"].to_s
      { "busId" => parse_jore(raw_code), "time" => parse_time(raw_time) }
    end
    departures
  end

  def parse_directions(stop_info)
    lines = stop_info["lines"]
    line_dir_array = lines.map { | messy_line_info | messy_line_info.split(":") }
    lines_with_directions_hash = {}
    line_dir_array.each { |line, direction| lines_with_directions_hash[parse_jore(line)] = direction }
    lines_with_directions_hash
  end

  # JORE code
  # The code consists of following parts:
  # 1. character = area/transport type code (e.g. 2)
  # 2.-4. character = line code (e.g. 102)
  # 5. character = letter variant (e.g. T)
  # 6. character = letter variant or numeric variant (numeric variants are usually not used for base routes and are not shown to the end users)
  # 7. character = direction (always 1 or 2), not shown to end users

  def parse_jore(jore)
    interesting_part = jore[1..5].strip
    while interesting_part.start_with?("0")
      interesting_part = interesting_part[1..-1]
    end
    interesting_part
  end

  def parse_time(timeStr)
    hour = nil
    m_start_index = 2
    if timeStr.length == 4
      hour = timeStr[0..1].to_i
    elsif timeStr.length == 3
      hour = timeStr[0..0].to_i
      m_start_index = 1
    else
      raise Exception.new("Invalid time string #{timeStr}")
    end
    minutes = timeStr[m_start_index..m_start_index+1].to_i
    BusTime.new(hour, minutes)
  end

end
