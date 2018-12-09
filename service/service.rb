require 'sinatra'
require 'json'

set :bind, '0.0.0.0'

get '/' do
	content_type 'application/json'
	{status: :ok, message: 'Success'}.to_json
end

