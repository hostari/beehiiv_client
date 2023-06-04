module BeehiivMethods
  extend self

  macro add_retrieve_method(*arguments)
{% begin %}
  def self.retrieve(client : HTTP::Client, publication_id : String, {{*arguments}}) : Object({{@type.id}})
    body = { "expand" => "stats" }.to_json
    params = HTTP::Params.build do |params|
      params["expand"] = "stats"
    end
    response = client.get("/v2/publications/#{publication_id}/#{"{{@type.id.gsub(/Beehiiv::/, "").underscore.gsub(/::/, "/")}}"}s/#{id}", params: params)

    if response.status_code == 200
      Object({{@type.id}}).from_json(response.body)
    else
      raise Error.from_json(response.body, "error")
    end
  end

  def self.retrieve({{@type.id.gsub(/Beehiiv::/, "").downcase.underscore.gsub(/::/, "_").id}} : {{@type.id}})
    retrieve({{@type.id.gsub(/Beehiiv::/, "").downcase.underscore.gsub(/::/, "_").id}}.id)
  end
{% end %}
end
end
