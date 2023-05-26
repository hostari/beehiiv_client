module BeehiivMethods
  extend self

  macro add_delete_method
{% begin %}
  def self.delete(client : HTTP::Client, publication_id : String, id : String)
    response = client.delete("/v2/publications/#{publication_id}/#{"{{@type.id.gsub(/Beehiiv::/, "").underscore.gsub(/::/, "/")}}"}s/#{id}")

    if response.status_code == 204
      true
    else
      raise Error.from_json(response.body, "error")
    end
  end

  def self.delete({{@type.id.gsub(/Beehiiv::/, "").downcase.underscore.gsub(/::/, "_").id}} : {{@type.id}})
    delete({{@type.id.gsub(/Beehiiv::/, "").downcase.underscore.gsub(/::/, "_").id}}.id)
  end
{% end %}
end
end
