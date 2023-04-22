require "../../spec_helper"

describe Beehiiv::Publication do
  it "retrieves all publications associated with your API key" do
    WebMock.stub(:get, "https://api.beehiiv.com/v2/publications")
      .to_return(status: 200, body: File.read("spec/support/publications_index.json"), headers: {"Content-Type" => "application/json"})

    publications = Beehiiv::Publication.list
    publications.first.id.should eq("pub_00000000-0000-0000-0000-000000000000")
  end
  it "retrieves a single publication associated with your API key" do
    id = "pub_00000000-0000-0000-0000-000000000000"
    WebMock.stub(:get, "https://api.beehiiv.com/v2/publications/#{id}")
      .to_return(status: 200, body: File.read("spec/support/publications_show.json"), headers: {"Content-Type" => "application/json"})

    publication = Beehiiv::Publication.retrieve(id).data
    publication.id.should eq(id)
  end
end
