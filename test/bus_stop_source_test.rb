require 'test/unit'
require 'bus_stop_source'

class TestBuStopSource < Test::Unit::TestCase

  def setup
    @net_source = FakeNetSource.new
    @file_source = FakeFileSource.new
    @source = BusStopSource.new("77", 2, @net_source, @file_source)
  end

  def test_interactions_all_from_file
    @file_source.times = {"72" => [5, 15]}
    times = @source.get_times
    assert_equal(1, @file_source.call_count)
    assert_equal(0, @net_source.call_count)
    assert_equal(@file_source.times, times)
  end

  def test_interactions_one_from_file_one_online
    @file_source.times = {"72" => [1,2], "73" => [1] }
    @net_source.raw = "abc"
    @net_source.times = {"72" => [1,2], "73" => [1,2] }
    times = @source.get_times
    assert_equal(1, @file_source.call_count)
    assert_equal(1, @net_source.call_count)
    assert_equal("abc", @file_source.raw)
  end
    
end

class FakeNetSource
  attr_accessor :times, :call_count, :raw

  def initialize
    @times = {}
    @call_count = 0
    @raw = nil
  end
  
  def get_times
    @call_count += 1
    return @times, @raw
  end

end

class FakeFileSource
  attr_accessor :times, :raw, :call_count

  def initialize
    @times = {}
    @raw = nil
    @call_count = 0
  end
  
  def get_times
    @call_count += 1
    return @times
  end

  def cache_raw(raw)
    @raw = raw
  end
  
end
