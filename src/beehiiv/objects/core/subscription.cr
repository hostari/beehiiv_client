@[EventPayload]
class Beehiiv::Subscription
  include JSON::Serializable
  include BeehiivMethods

  add_retrieve_method(
    id : String
  )
  add_list_method
  add_delete_method

  enum Status
    Validating
    Invalid
    Pending
    Active
    Inactive
  end

  enum SubscriptionTier
    Free
    Premium
  end

  getter id : String
  getter email : String

  @[JSON::Field(converter: Enum::StringConverter(Beehiiv::Subscription::Status))]
  getter status : Status

  @[JSON::Field(converter: Time::EpochConverter)]
  getter created : Time?

  @[JSON::Field(converter: Enum::StringConverter(Beehiiv::Subscription::SubscriptionTier))]
  getter subscription_tier : SubscriptionTier

  getter utm_source : String?
  getter utm_medium : String?
  getter utm_channel : String?
  getter utm_campaign : String?
  getter referring_site : String?
  getter referral_code : String?
end
