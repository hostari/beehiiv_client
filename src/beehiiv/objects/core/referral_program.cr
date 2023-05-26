@[EventPayload]
class Beehiiv::ReferralProgram
  include JSON::Serializable

  def self.retrieve(client : HTTP::Client, id : String)
    response = client.get("/v2/publications/#{id}/referral_program")

    if response.status_code == 200
      List(Beehiiv::ReferralProgram).from_json(response.body)
    else
      raise Error.from_json(response.body, "error")
    end
  end

  class Reward
    include JSON::Serializable

    getter id : String
    getter name : String
    getter description : String
    getter image_url : String

    @[JSON::Field(key: "type")]
    getter _type : String
  end

  getter id : String
  getter auto_fulfill : Bool
  getter num_referrals : Int32
  getter reward : Reward?
end
