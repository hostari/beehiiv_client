@[EventPayload]
class Beehiiv::Publication
  include JSON::Serializable

  def self.retrieve(client : HTTP::Client, id : String)
    response = client.get("/v2/publications/#{id}")

    if response.status_code == 200
      Object(Beehiiv::Publication).from_json(response.body)
    else
      raise Error.from_json(response.body, "error")
    end
  end

  def self.list(client : HTTP::Client)
    response = client.get("/v2/publications")

    if response.status_code == 200
      List(Beehiiv::Publication).from_json(response.body)
    else
      raise Error.from_json(response.body, "error")
    end
  end

  class Stats
    include JSON::Serializable

    getter active_subscriptions : Int32
    getter active_premium_subscriptions : Int32
    getter active_free_subscriptions : Int32
    getter average_open_rate : Float64
    getter average_click_rate : Float64
    getter total_sent : Int32
    getter total_unique_opened : Int32
    getter total_clicked : Int32
  end

  getter id : String
  getter name : String
  getter referral_program_enabled : Bool
  getter stats : Stats?
end
