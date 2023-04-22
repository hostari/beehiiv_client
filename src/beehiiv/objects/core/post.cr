@[EventPayload]
class Beehiiv::Post
  include JSON::Serializable
  include BeehiivMethods

  add_retrieve_method(
    id : String
  )
  add_list_method
  add_delete_method

  enum Status
    Draft
    Confirmed
    Archived
  end

  enum Audience
    Free
    Premium
    Both
  end

  enum Platform
    Web
    Email
    Both
  end

  class Content
    include JSON::Serializable

    getter free : FreeContent?
    getter premium : PremiumContent?

    class FreeContent
      include JSON::Serializable

      getter web : String?
      getter email : String?
      getter rss : String?
    end

    class PremiumContent
      include JSON::Serializable

      getter web : String?
      getter email : String?
      getter rss : String?
    end
  end

  class Stats
    include JSON::Serializable

    getter email : EmailStats?
    getter web : WebStats?
    getter clicks : Array(ClickStats)?

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

    class WebStats
      include JSON::Serializable

      getter views : Int32
      getter clicks : Int32
    end

    class ClickStats
      include JSON::Serializable

      class EmailStats
        include JSON::Serializable

        getter clicks : Int32
        getter unique_clicks : Int32
        getter click_through_rate : Float64
      end

      class WebStats
        include JSON::Serializable

        getter clicks : Int32
        getter unique_clicks : Int32
        getter click_through_rate : Float64
      end

      getter url : String
      getter email : EmailStats?
      getter web : WebStats?
      getter total_clicks : Int32
      getter total_unique_clicks : Int32
      getter total_click_through_rate : Float64
    end
  end

  getter id : String
  getter subtitle : String?
  getter title : String?
  getter authors : Array(String)?

  @[JSON::Field(converter: Time::EpochConverter)]
  getter created : Time?

  @[JSON::Field(converter: Enum::StringConverter(Beehiiv::Post::Status))]
  getter status : Status

  @[JSON::Field(converter: Time::EpochConverter)]
  getter publish_date : Time?

  @[JSON::Field(converter: Time::EpochConverter)]
  getter displayed_date : Time?

  getter split_tested : Bool?

  getter subject_line : String?
  getter preview_text : String?
  getter slug : String?
  getter thumbnail_url : String?
  getter web_url : String?

  @[JSON::Field(converter: Enum::StringConverter(Beehiiv::Post::Audience))]
  getter audience : Audience

  @[JSON::Field(converter: Enum::StringConverter(Beehiiv::Post::Platform))]
  getter platform : Platform

  getter content_tags : Array(String)?

  getter content : Content?
  getter stats : Stats?
end
