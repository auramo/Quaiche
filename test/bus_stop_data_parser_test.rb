# -*- coding: utf-8 -*-
require 'test/unit'
require 'bus_stop_data_parser'
require 'bus_data'

BUS_STOP_3363 =<<END
1937|Tapanilan Urheiluk.|Er?tie|Helsinki
2155|72|Rautatientori|1072  2
2220|72|Rautatientori|1072  2
2245|72|Rautatientori|1072  2
2315|72|Rautatientori|1072  2
2345|72|Rautatientori|1072  2
2410|72|Rautatientori|1072  2
2435|72|Rautatientori|1072  2
2500|72|Rautatientori|1072  2
END

BUS_STOP_3331 =<<END
1941|Kotinummentie|Tapaninkyl?ntie|Helsinki
2140|73|Suutarila|1073  1
2207|73N|Suutarila|1073N 1
2231|73N|Suutarila|1073N 1
2256|73N|Suutarila|1073N 1
2324|73N|Suutarila|1073N 1
2348|73N|Suutarila|1073N 1
2413|73N|Suutarila|1073N 1
2437|73N|Suutarila|1073N 1
2502|73N|Suutarila|1073N 1
2527|73N|Suutarila|1073N 1
2552|73N|Suutarila|1073N 1
END

BUS_STOP_3331_2 =<<END
1941|Kotinummentie|Tapaninkyläntie|Helsinki
826|73|Suutarila|1073  1
END

Bus_72 = BusWithDirection.new("72", "Rautatientori")
Bus_73 = BusWithDirection.new("73", "Suutarila")
Bus_73N = BusWithDirection.new("73N", "Suutarila")

class TestBusStopDataParser < Test::Unit::TestCase

  def setup
    @parser = BusStopDataParser.new
  end

  def test_stop_3363
    parsed = @parser.parse(BUS_STOP_3363)
    assert(parsed.key?(Bus_72))
    assert_equal(1, parsed.length)
    times = parsed[Bus_72]
    assert_equal(8, times.length)
    time = times[0]
    assert_equal(21, time.hour)
    assert_equal(55, time.min)
    time = times[7]
    assert_equal(25, time.hour)
    assert_equal(00, time.min)
  end

  def test_stop_3331
    parsed = @parser.parse(BUS_STOP_3331)
    assert_equal(2, parsed.length)
    time = parsed[Bus_73][0]
    assert_equal(21, time.hour)
    assert_equal(40, time.min)
    time = parsed[Bus_73N][2]
    assert_equal(22, time.hour)
    assert_equal(56, time.min)
  end

  def test_stop_3331_2
    parsed = @parser.parse(BUS_STOP_3331_2)
    assert_equal(1, parsed.length)
    time = parsed[Bus_73][0]
    assert_equal(8, time.hour)
    assert_equal(26, time.min)
  end
  
  def test_empty
    assert_equal(0, @parser.parse("").length)
  end

  def test_equals
    assert_equal(BusWithDirection.new("a", "a"),
                 BusWithDirection.new("a", "a"))
    assert_not_equal(BusWithDirection.new("a", "a"),
                     BusWithDirection.new("a", "b"))
    assert_not_equal(BusWithDirection.new("a", "a"),
                     BusWithDirection.new("b", "a"))
  end
  
end
