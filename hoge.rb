require "faraday"

conn = Faraday::Connection.new(url: 'https://api.parse.com') do |builder|
  builder.request :url_encoded
  builder.adapter :net_http
end

response = conn.get do |request|
  request.url '/1/classes/Foo'
  request.headers = {
    'X-Parse-Application-Id' => '',
    'X-Parse-REST-API-Key' => '',
  }
end

puts response.body