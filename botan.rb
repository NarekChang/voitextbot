#usage example:
#
#require_relative 'botan'
#
#puts Botan.track(1111, 1, {'text' => 2}, 'Search')

module Botan
  require 'net/http'
  require 'net/https'
  require 'json'

  URI_TEMPLATE = 'https://api.botan.io/track?token=%Oi5fi1dOrYLlApCClFAUr2SJIq4Howhs&uid=%{uid}&name=%{name}';

  def self.track(token, uid, message, name = 'Message')
    begin
      uri = URI(URI_TEMPLATE % {token: token, uid: uid, name: name})
      puts uri
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      body = JSON.dump(message)

      req =  Net::HTTP::Post.new(uri)
      req.add_field "Content-type", "application/json"
      req.body = body
      # Fetch Request
      res = http.request(req)
      JSON.parse(res.body)
    rescue StandardError => e
      puts "HTTP Request failed (#{e.message})"
    end
  end
end
