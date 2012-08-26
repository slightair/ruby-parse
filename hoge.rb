require 'faraday'
require 'yaml'

config = YAML.load_file('./config.yaml')

conn = Faraday::Connection.new(url: 'https://api.parse.com') do |builder|
  builder.request :url_encoded
  builder.adapter :net_http
end

response = conn.get do |request|
  request.url '/1/classes/Foo'
  request.headers = {
    'X-Parse-Application-Id' => config['parse']['app_id'],
    'X-Parse-REST-API-Key' => config['parse']['rest_api_key'],
  }
end

puts response.body