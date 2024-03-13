# require 'faker'
# require 'net/http'
# require 'json'
# require 'nokogiri'
# require 'open-uri'

# api_key = "db6a8b3c79944976acd8ca04cd447035"

# ing_uri = URI.parse("https://api.spoonacular.com/food/ingredients/map")
# ing_params = { apiKey: api_key }
# ing_uri.query = URI.encode_www_form(ing_params)

# # Construct the request object
# ing_http = Net::HTTP.new(ing_uri.host, ing_uri.port)
# ing_http.use_ssl = true

# ing_request = Net::HTTP::Post.new(ing_uri.request_uri)
# ing_request["Content-Type"] = "application/json"

# # Add any required parameters to the request body
# ing_request.body = {
#   "ingredients": ["cwnkjweceoce"],
#   "servings": 2
# }.to_json

# ing_response = ing_http.request(ing_request)

# if ing_response.body == "[]"
#   title = "Kerygold Cooking Magic 250ml"
# else
#   title = JSON.parse(ing_response.body)[0]["products"][0]["title"]
# end
