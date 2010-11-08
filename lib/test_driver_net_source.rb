require 'net_source'
require 'next_time_extractor'

net_source = NetBusStopSource.new("3363", NextTimeExtractor.new(2, ["72"]), "twosheds", "alalal")
times = net_source.get_times
puts times


