require 'bus_data'

class BusStopDataParser
  # Returns a hash of lists with OpenStucts (hour and minutes) in them:
  # bus_number -> (hour, minutes), (hour, minutes)
  def parse(data)
    first = true
    parsed = {}
    data.each do |row|
      unless first
        cols = row.split("|")
        busId = cols[1].strip
        direction = cols[2].strip
        bus = BusWithDirection.new(busId, direction)
        timeStr = cols[0].strip
        add_time(parsed, bus, timeStr)
      end
      first = false if first
    end
    parsed
  end

  def add_time(parsed, busId, timeStr)
    if not parsed.key?(busId)
      parsed[busId] = []
    end
    parsed[busId] << parse_time(timeStr)
    parsed
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
      raise Exception("Invalid time string #{timeStr}")
    end
    minutes = timeStr[m_start_index..m_start_index+1].to_i
    BusTime.new(hour, minutes)
  end
end
