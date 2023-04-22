require "json"
require "http/client"
require "./ext/**"

class Beehiiv
  BASE_URL = URI.parse("https://api.beehiiv.com")

  def self.client(api_key : String = "123") : HTTP::Client
    client = HTTP::Client.new(BASE_URL)
    client.before_request do |request|
      request.headers["Authorization"] = "Bearer #{api_key}"
    end

    client
  end
end

annotation EventPayload
end

require "./beehiiv/**"
