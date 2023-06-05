require "../../spec_helper"

describe Beehiiv::Publication do
  it "retrieves all publications associated with your API key" do
    WebMock.stub(:get, "https://api.beehiiv.com/v2/publications")
      .to_return(status: 200, body: File.read("spec/support/publications_index.json"), headers: {"Content-Type" => "application/json"})

    client = Beehiiv.client
    publications = Beehiiv::Publication.list(client)
    publications.first.id.should eq("pub_00000000-0000-0000-0000-000000000000")
  end
  it "retrieves a single publication associated with your API key" do
    id = "pub_00000000-0000-0000-0000-000000000000"
    WebMock.stub(:get, "https://api.beehiiv.com/v2/publications/#{id}?expand=stats")
      .to_return(status: 200, body: File.read("spec/support/publications_show.json"), headers: {"Content-Type" => "application/json"})

    client = Beehiiv.client
    publication = Beehiiv::Publication.retrieve(client, id).data
    publication.id.should eq(id)
  end

  it "retrieves a single publication associated with your API key with expanded data for stats" do
    id = "pub_00000000-0000-0000-0000-000000000000"
    WebMock.stub(:get, "https://api.beehiiv.com/v2/publications/#{id}?expand=stats")
      .to_return(status: 200, body: File.read("spec/support/publications_show_with_stats.json"), headers: {"Content-Type" => "application/json"})

    client = Beehiiv.client
    publication_stats = Beehiiv::Publication.retrieve(client, id).data.stats

    publication_stats.not_nil!.active_subscriptions.should eq(100)
  end
end
