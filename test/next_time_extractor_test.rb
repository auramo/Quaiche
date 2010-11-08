require 'test/unit'
require 'bus_data'
require 'next_time_extractor'

Bus_72 = BusWithDirection.new("72", "Rautatientori")
Bus_73N = BusWithDirection.new("73N", "Suutarila")
Bus_666 = BusWithDirection.new("666", "A")

TEST_DATA1 =
{
  Bus_72 => [BusTime.new(9, 00), BusTime.new(10,01), BusTime.new(15, 15), BusTime.new(17,20)],
  Bus_73N => [BusTime.new(8, 00), BusTime.new(10,15), BusTime.new(12, 00)],
  Bus_666 => []
}

class NextTimeExtractorTest < Test::Unit::TestCase

  def setup
    @extractor = NextTimeExtractor.new(2, ["72", "73N"], FakeTime)
  end

  def test_two_buses_with_enough_data
    FakeTime.set_hour(10)
    FakeTime.set_min(00)
    extracted = @extractor.extract(TEST_DATA1)

    assert_equal(2, extracted.length)
    
    for_72 = extracted[Bus_72]
    assert_equal(2, for_72.length)
    assert_equal(1, for_72[0])
    assert_equal(315, for_72[1])

    for_73n = extracted[Bus_73N]
    assert_equal(2, for_73n.length)
    assert_equal(15, for_73n[0])
    assert_equal(120, for_73n[1])
  end

  def test_over_midnight_case
    data = {Bus_72 => [BusTime.new(1,12)]}
    FakeTime.set_hour(23)
    FakeTime.set_min(00)
    extracted = @extractor.extract(data)
    assert_equal(1, extracted.length)
    mins = extracted[Bus_72][0]
    assert_equal(132, mins)
  end
  
end


class FakeTime
  @@hour = 0
  @@min = 0

  def self.set_hour(hour)
    @@hour = hour
  end

  def self.set_min(min)
    @@min = min
  end
  
  def hour
    @@hour
  end

  def min
    @@min
  end

end
    
