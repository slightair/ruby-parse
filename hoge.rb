require 'faraday'
require 'faraday_middleware'
require 'yaml'

require 'pp'

config = YAML.load_file('./config.yaml')

conn = Faraday.new 'https://api.parse.com' do |builder|
  builder.request :json
  builder.response :json
  builder.adapter Faraday.default_adapter
  builder.headers = {
    'X-Parse-Application-Id' => config['parse']['app_id'],
    'X-Parse-REST-API-Key' => config['parse']['rest_api_key'],
    'Content-Type' => 'application/json',
  }
end

# create object
response = conn.post '/1/classes/Player', {
  :name => 'oreo',
  :score => 1000,
}
pp response.body

# query
response = conn.get '/1/classes/Player', {
  :where => {
    :name => 'oreo'
  }
}
pp response.body

oreos = response.body['results']
first_oreo = oreos.first

# update
response = conn.put "/1/classes/Player/#{first_oreo['objectId']}", {
    :score => rand(1000)
}
pp response.body