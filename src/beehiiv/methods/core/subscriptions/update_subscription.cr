class Beehiiv::Subscription
  class CustomField
    getter name, value, delete
    def initialize(@name : String, @value : String = "", @delete : Bool = false)
    end
  end
  def self.update(
    publication_id : String,
    id : String,
    unsubscribe : Bool  = false,
    custom_fields : Hash(String, String | Bool)? = nil
  ) : Object(Subscription) forall T, U
    io = IO::Memory.new
    builder = ParamsBuilder.new(io)

    {% for x in %w(unsubscribe custom_fields) %}
      builder.add({{x}}, {{x.id}}) unless {{x.id}}.nil?
    {% end %}

    response = Beehiiv.client.patch("/v2/publications/#{publication_id}/subscriptions/#{id}", form: io.to_s)

    if response.status_code == 200
      Object(Subscription).from_json(response.body)
    else
      raise Error.from_json(response.body, "error")
    end
  end
end
