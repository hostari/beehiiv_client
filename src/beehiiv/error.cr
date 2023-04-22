class Beehiiv::Error < Exception
  include JSON::Serializable

  enum Type
    ApiConnectionError
    ApiError
    AuthenticationError
    CardError
    IdempotencyError
    InvalidRequestError
    RateLimitError
  end

  @[JSON::Field(converter: Enum::StringConverter(Beehiiv::Error::Type))]
  property type : Beehiiv::Error::Type
  property charge : String?
  property code : String?
  property decline_code : String?
  property doc_url : String?
  property message : String?
  property param : String?
end
