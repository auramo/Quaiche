
class BusTime
  attr_reader :hour, :min
  def initialize(hour, minutes)
    @hour = hour
    @min = minutes
  end
end

class NextBusTimes
  attr_reader :minutes_until, :time
  def initialize(minutes_until, time)
    @minutes_until = minutes_until
    @time = time
  end
  def to_s
     @minutes_until.to_s + "(" + format_time_digit(@time.hour) + ":" + format_time_digit(@time.min) + ")"
  end
  def format_time_digit(digit)
    d_str = digit.to_s
    if d_str.length == 1
      return "0" + d_str
    else
      return d_str
    end
  end
end

class BusWithDirection
  attr_reader :name, :last_stop
  def initialize(name, last_stop)
    @name = name
    @last_stop = last_stop
  end

  def eql?(object)
    object.equal?(self) ||
      (object.instance_of?(self.class) &&
       object.name == name &&
       object.last_stop == last_stop)
  end

  alias == eql?
  
  def hash
    @name.hash ^ @last_stop.hash
  end
  
  def to_s
    @name + " " + @last_stop
  end
  
end
