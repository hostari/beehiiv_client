require "../../spec_helper"

describe Beehiiv::EmailBlast do
  it "retrieves all Email Blasts belonging to a specific publication" do
    publication_id = "pub_00000000-0000-0000-0000-000000000000"
    email_blast_id = "blast_00000000-0000-0000-0000-000000000000"
    WebMock.stub(:get, "https://api.beehiiv.com/v2/publications/#{publication_id}/email_blasts")
      .to_return(status: 200, body: File.read("spec/support/email_blasts_index.json"), headers: {"Content-Type" => "application/json"})

    client = Beehiiv.client
    email_blasts = Beehiiv::EmailBlast.list(client, publication_id)
    email_blasts.first.id.should eq(email_blast_id)
  end

  it "retrieves an Email Blast belonging to a specific publication" do
    publication_id = "pub_00000000-0000-0000-0000-000000000000"
    email_blast_id = "blast_00000000-0000-0000-0000-000000000000"
    WebMock.stub(:get, "https://api.beehiiv.com/v2/publications/#{publication_id}/email_blasts/#{email_blast_id}") # ?expand%5B%5D=stats&expand%5B%5D=free_email_content&expand%5B%5D=premium_email_content
      .to_return(status: 200, body: File.read("spec/support/email_blasts_show.json"), headers: {"Content-Type" => "application/json"})

    client = Beehiiv.client
    email_blast = Beehiiv::EmailBlast.retrieve(client, publication_id, id: email_blast_id).data
    email_blast.id.should eq(email_blast_id)
  end
end
