require 'global_settings'
require 'logger'
require 'bus_stop_data_parser'
require 'net/http'
require 'cgi'

class NetBusStopSource
  def initialize(bus_stop, next_time_extractor, user, pass)
    @bus_stop = bus_stop
    @next_time_extractor = next_time_extractor
    @parser = BusStopDataParser.new
    @user = user
    @pass = pass
  end

  def get_times
    params = {:stop => @bus_stop, :user => @user, :pass => @pass}
    Logger.info("Getting data for #{@bus_stop} from #{ServiceAddress}#{ServicePath} with user #{@user}")
    raw = http_get(ServiceAddress, ServicePath, params)
    Logger.info("Got raw data #{raw}")
    parsed = @parser.parse(raw)
    return @next_time_extractor.extract(parsed), raw
  end

  def http_get(domain,path,params)
    return Net::HTTP.get(domain, "#{path}?".concat(params.collect { |k,v| "#{k}=#{CGI::escape(v.to_s)}" }.join('&'))) if not params.nil?
    return Net::HTTP.get(domain, path)
  end
  
end
