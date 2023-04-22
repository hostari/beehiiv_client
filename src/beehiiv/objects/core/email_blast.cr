@[EventPayload]
class Beehiiv::EmailBlast
  include JSON::Serializable
  include BeehiivMethods

  add_retrieve_method(
    id : String
  )
  add_list_method

  enum Status
    Active
    Inactive
  end

  class Stats
    include JSON::Serializable

    getter email : EmailStats
    getter clicks : Array(ClickStats)

    class EmailStats
      include JSON::Serializable

      getter recipients : Int32
      getter opens : Int32
      getter unique_opens : Int32
      getter open_rate : Float64
      getter clicks : Int32
      getter unique_clicks : Int32
      getter click_rate : Float64
      getter unsubscribes : Int32
      getter spam_reports : Int32
    end

    class ClickStats
      include JSON::Serializable
      getter url : String
      getter total_clicks : Int32
      getter total_unique_clicks : Int32
      getter total_click_through_rate : Float64
    end
  end

  class Content
    include JSON::Serializable

    getter email : EmailContent

    class EmailContent
      include JSON::Serializable
      getter free : String?
      getter premium : String?
    end
  end

  getter id : String

  @[JSON::Field(converter: Time::EpochConverter)]
  getter created : Time?

  @[JSON::Field(converter: Enum::StringConverter(Beehiiv::EmailBlast::Status))]
  getter status : Status

  getter subject_line : String?
  getter preview_text : String?
  getter stats : Stats?
  getter content : Content?
end
