require 'faraday'
require 'yaml'
require 'json'

require 'pp'

config = YAML.load_file('./config.yaml')

conn = Faraday::Connection.new('https://api.parse.com') do |builder|
  builder.request :url_encoded
  builder.adapter :net_http
  builder.headers = {
    'X-Parse-Application-Id' => config['parse']['app_id'],
    'X-Parse-REST-API-Key' => config['parse']['rest_api_key'],
  }
end

response = conn.get '/1/classes/Foo'

pp JSON.parse(response.body)