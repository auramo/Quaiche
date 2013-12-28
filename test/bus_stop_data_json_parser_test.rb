# -*- coding: utf-8 -*-
require 'test/unit'
require 'bus_stop_data_parser'
require 'bus_data'

BUS_STOP_3363_JSON =<<END
[
    {
        "accessibility": {
            "accessibility": 0, 
            "bench_height": 0, 
            "class": 4, 
            "curb_height_road": 0, 
            "curb_height_sidewalk": 0, 
            "cycle_track_included": 0, 
            "cycle_track_position": 0, 
            "danger": 0, 
            "depth": 0, 
            "difference_waiting_area": 0, 
            "difference_warning_area": 0, 
            "length_tilt": 0, 
            "light": 0, 
            "lower_moulding": 0, 
            "max_width": 0, 
            "min_width": 0, 
            "notes": "", 
            "protecting_height": 0, 
            "rear_railing_height": 0, 
            "shelter": 0, 
            "stop_model": 0, 
            "trash_can": 0, 
            "unobstructed_access": 0, 
            "warning_area": 0, 
            "width_tilt": 0
        }, 
        "address_fi": "Er\u00e4tie", 
        "address_sv": "Jaktf\u00e4rdsv\u00e4gen", 
        "city_fi": "Helsinki", 
        "city_sv": "Helsingfors", 
        "code": "1392154", 
        "code_short": "3363", 
        "coords": "2556410,6684255", 
        "departures": [
            {
                "code": "1072  2", 
                "date": 20131228, 
                "time": 2108
            }, 
            {
                "code": "1072  2", 
                "date": 20131228, 
                "time": 2128
            }, 
            {
                "code": "1072  2", 
                "date": 20131228, 
                "time": 2148
            }, 
            {
                "code": "1072  2", 
                "date": 20131228, 
                "time": 2208
            }, 
            {
                "code": "1072  2", 
                "date": 20131228, 
                "time": 2237
            }
        ], 
        "lines": [
            "1072  1:Tapanila", 
            "1072  2:Rautatientori"
        ], 
        "name_fi": "Tapanilan Urheiluk.", 
        "name_sv": "Mosabacka Idrottsc.", 
        "omatlahdot_link": "http://www.omatlahdot.fi/omatlahdot/web?command=quicksearch&stopid=1392154&lang=1", 
        "timetable_link": "http://aikataulut.hsl.fi/pysakit/fi/1392154.html", 
        "wgs_coords": "25.01614,60.26573"
    }
]
END

BUS_STOP_3331_JSON =<<END
[
    {
        "accessibility": {
            "accessibility": 0, 
            "bench_height": 0, 
            "class": 4, 
            "curb_height_road": 0, 
            "curb_height_sidewalk": 0, 
            "cycle_track_included": 0, 
            "cycle_track_position": 0, 
            "danger": 0, 
            "depth": 0, 
            "difference_waiting_area": 0, 
            "difference_warning_area": 0, 
            "length_tilt": 0, 
            "light": 0, 
            "lower_moulding": 0, 
            "max_width": 0, 
            "min_width": 0, 
            "notes": "", 
            "protecting_height": 0, 
            "rear_railing_height": 0, 
            "shelter": 0, 
            "stop_model": 0, 
            "trash_can": 0, 
            "unobstructed_access": 0, 
            "warning_area": 0, 
            "width_tilt": 0
        }, 
        "address_fi": "Tapaninkyl\u00e4ntie", 
        "address_sv": "Staffansbyv\u00e4gen", 
        "city_fi": "Helsinki", 
        "city_sv": "Helsingfors", 
        "code": "1392165", 
        "code_short": "3331", 
        "coords": "2556380,6684481", 
        "departures": [
            {
                "code": "1073N 1", 
                "date": 20131228, 
                "time": 2359
            }, 
            {
                "code": "1073N 1", 
                "date": 20131228, 
                "time": 2428
            }, 
            {
                "code": "1073N 1", 
                "date": 20131228, 
                "time": 2458
            }, 
            {
                "code": "1073N 1", 
                "date": 20131228, 
                "time": 2526
            }
        ], 
        "lines": [
            "1073  1:Ala-Tikkurila", 
            "1073N 1:Suutarila"
        ], 
        "name_fi": "Kotinummentie", 
        "name_sv": "Hemmalmsv\u00e4gen", 
        "omatlahdot_link": "http://www.omatlahdot.fi/omatlahdot/web?command=quicksearch&stopid=1392165&lang=1", 
        "timetable_link": "http://aikataulut.hsl.fi/pysakit/fi/1392165.html", 
        "wgs_coords": "25.01539,60.26788"
    }
]
END

Bus_72 = BusWithDirection.new("72", "Rautatientori")
Bus_73 = BusWithDirection.new("73", "Suutarila")
Bus_73N = BusWithDirection.new("73N", "Suutarila")

class TestBusStopDataJsonParser < Test::Unit::TestCase

  def setup
    @parser = BusStopDataJsonParser.new
  end

  def xtest_stop_3363
    parsed = @parser.parse(BUS_STOP_3363_JSON)
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
    parsed = @parser.parse(BUS_STOP_3331_JSON)
    assert_equal(1, parsed.length)
    time = parsed[Bus_73N][0]
    assert_equal(23, time.hour)
    assert_equal(59, time.min)
    time = parsed[Bus_73N][3]
    assert_equal(25, time.hour)
    assert_equal(26, time.min)
  end
  
  def xtest_empty
    assert_equal(0, @parser.parse("").length)
  end

  
  # JORE is the format of the format of the line code. E.g. "1073N 1" means 73N, the interesting part
  # for us is 073N which is the actual line code + letter variant (we'll remove the trailing zeros)
  def test_jore_parsing
    assert_equal("73N", @parser.parse_jore("1073N 1"))
    assert_equal("519", @parser.parse_jore("1519  1"))
  end

  def test_parse_directions
    parsed = JSON.parse(BUS_STOP_3331_JSON)
    directions = @parser.parse_directions(parsed[0])
    puts directions
    assert_equal("Suutarila", directions["73N"])
    assert_equal("Ala-Tikkurila", directions["73"])
  end

  def test_parse_departures
    parsed = JSON.parse(BUS_STOP_3331_JSON)
    departures = @parser.parse_departures(parsed[0])
    last = departures[-1]
    assert_equal("73N", last["busId"])
    assert_equal(25, last["time"].hour)
    assert_equal(26, last["time"].min)
  end
  
end
