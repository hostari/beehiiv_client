class Beehiiv::Subscription
  def self.create(
    client : HTTP::Client,
    publication_id : String,
    email : String,
    reactivate_existing : Bool = false,
    send_welcome_email : Bool = false,
    utm_source : String? = nil,
    utm_medium : String? = nil,
    utm_campaign : String? = nil,
    referring_site : String? = nil,
    referral_code : String? = nil,
    custom_fields : Array(CustomField)? = nil
  ) : Object(Subscription) forall T, U
    io = IO::Memory.new
    builder = ParamsBuilder.new(io)

    {% for x in %w(email reactivate_existing send_welcome_email utm_source utm_medium utm_campaign referring_site referral_code custom_fields) %}
      builder.add({{x}}, {{x.id}}) unless {{x.id}}.nil?
    {% end %}

    response = client.post("/v2/publications/#{publication_id}/subscriptions", form: io.to_s)

    if response.status_code == 200
      Object(Subscription).from_json(response.body)
    else
      raise Error.from_json(response.body, "error")
    end
  end
end
