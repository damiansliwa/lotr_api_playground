class ApiController < ActionController::API
	# Defines location for URLs
	def default_url_options
	    { host: 'localhost', port: 3000 }
	end
end