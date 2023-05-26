@[EventPayload]
class Beehiiv::Segment
  include JSON::Serializable
  include BeehiivMethods

  add_retrieve_method(
    id : String
  )
  add_list_method
  add_delete_method

  def self.expand_results(client : HTTP::Client, publication_id : String, id : String)
    response = client.get("/v2/publications/#{publication_id}/segments/#{id}/results")

    if response.status_code == 200
      List(String).from_json(response.body)
    else
      raise Error.from_json(response.body, "error")
    end
  end

  enum SegmentType
    Dynamic
    Static
    Manual
  end

  enum Status
    Pending
    Processing
    Completed
    Failed
  end

  getter id : String
  getter name : String

  @[JSON::Field(key: "type", converter: Enum::StringConverter(Beehiiv::Segment::SegmentType))]
  getter segment_type : SegmentType

  @[JSON::Field(converter: Time::EpochConverter)]
  getter last_calculated : Time?

  getter total_results : Int32
  getter status : Status
  getter active : Bool
end
