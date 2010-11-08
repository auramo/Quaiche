require 'file_source'
require 'next_time_extractor'
require 'global_settings'
require 'fileutils'

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

FileUtils.mkdir AppFilesPath

file_source = FileBusStopSource.new("3363", NextTimeExtractor.new(2, ["72"]))
file_source.get_times
file_source.cache_raw(BUS_STOP_3363)
file_source.get_times

