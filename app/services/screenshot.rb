require 'cgi' unless defined?(CGI)
require 'digest' unless defined?(Digest)

class Screenshot
  attr_reader :apikey, :secret, :query_string, :token
  def initialize options
    @apikey = "#{Rails.application.credentials.url2png[:api_key]}"
    @secret = "#{Rails.application.credentials.url2png[:secret]}"
    @query_string = options.sort.map { |k,v| "#{CGI::escape(k.to_s)}=#{CGI::escape(v.to_s)}" }.join("&")
    @token = Digest::MD5.hexdigest(query_string + secret)
  end

  def url
    "http://api.url2png.com/v6/#{@apikey}/#{@token}/png/?#{@query_string}"
  end
end
