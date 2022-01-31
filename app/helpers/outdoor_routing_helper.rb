require 'httparty'
require 'json'

module OutdoorRoutingHelper
  def self.routing_url(start, dest)
    "http://routing.openstreetmap.de/routed-foot/route/v1/driving/#{start[1]},#{start[0]};#{dest[1]},#{dest[0]}?overview=full&geometries=geojson"
  end

  def self.calculate_route(start, destination)
    begin
      response = HTTParty.get(routing_url(start, destination))
      return unless response.code == 200 # OPTIMIZE: give User feedback

      JSON.parse(response.body)["routes"][0]
    rescue StandardError
      # OPTIMIZE: give User feedback
    end
  end

  def self.transform_route_to_polyline(route)
    route["geometry"]["coordinates"].map do |(long, lat)|
      [lat, long]
    end
  end
end
