
class BusTime
  attr_reader :hour, :min
  def initialize(hour, minutes)
    @hour = hour
    @min = minutes
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
