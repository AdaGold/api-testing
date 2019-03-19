require "httparty"

#Starter Code:

BASE_URL = "https://us1.locationiq.com/v1/search.php"
KEY = ENV["LOCATIONIQ_TOKEN"]

class SearchError < StandardError; end

def get_location(search_term)
  query = {
    q: search_term,
    key: KEY,
    format: "json",
  }
  response = HTTParty.get(BASE_URL, query: query)

  unless response.code == 200
    raise SearchError, "Cannot find #{search_term}"
  end

  return {
           search_term => {
             lat: response.first["lat"],
             lon: response.first["lon"],
           },
         }
end

#Example Output:
#{"Great Pyramind of Giza"=>{"lat"=>29.9792345, "lng"=>31.1342019}, "Hanging Gardens of Babylon"=>{"lat"=>32.5422374, "lng"=>44.42103609999999}, "Colossus of Rhodes"=>{"lat"=>36.45106560000001, "lng"=>28.2258333}, "Pharos of Alexandria"=>{"lat"=>38.7904054, "lng"=>-77.040581}, "Statue of Zeus at Olympia"=>{"lat"=>37.6379375, "lng"=>21.6302601}, "Temple of Artemis"=>{"lat"=>37.9498715, "lng"=>27.3633807}, "Mausoleum at Halicarnassus"=>{"lat"=>37.038132, "lng"=>27.4243849}}
