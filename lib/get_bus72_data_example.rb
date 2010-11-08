require 'net/http'
require 'cgi'

def http_get(domain,path,params)
    return Net::HTTP.get(domain, "#{path}?".concat(params.collect { |k,v| "#{k}=#{CGI::escape(v.to_s)}" }.join('&'))) if not params.nil?
    return Net::HTTP.get(domain, path)
end

params = {:stop => 3363, :user => "twosheds", :pass => "alalal"}
print http_get("api.reittiopas.fi", "/public-ytv/fi/api/", params)


