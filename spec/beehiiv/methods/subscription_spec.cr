require "../../spec_helper"

describe Beehiiv::Subscription do
  it "creates a subscription for a publication" do
    publication_id = "pub_00000000-0000-0000-0000-000000000000"
    WebMock.stub(:post, "https://api.beehiiv.com/v2/publications/#{publication_id}/subscriptions")
      .to_return(status: 200, body: File.read("spec/support/subscriptions_create.json"), headers: {"Content-Type" => "application/json"})

    client = Beehiiv.client
    subscription = Beehiiv::Subscription.create(
      client,
      publication_id,
      email: "example@example.com",
      reactivate_existing: false,
      send_welcome_email: false,
      utm_source: "Twitter",
      utm_medium: "organic",
      utm_campaign: "string",
      referring_site: "https://www.blog.com",
      referral_code: "string"
    ).data

    subscription.email.should eq("example@example.com")
  end
  it "retrieves all subscriptions belonging to a specific publication" do
    publication_id = "pub_00000000-0000-0000-0000-000000000000"
    WebMock.stub(:get, "https://api.beehiiv.com/v2/publications/#{publication_id}/subscriptions")
      .to_return(status: 200, body: File.read("spec/support/subscriptions_index.json"), headers: {"Content-Type" => "application/json"})

    client = Beehiiv.client
    subscriptions = Beehiiv::Subscription.list(client, publication_id)
    subscriptions.first.id.should eq("sub_00000000-0000-0000-0000-000000000000")
  end
  it "retrieves a single subscription belonging to a specific publication" do
    publication_id = "pub_00000000-0000-0000-0000-000000000000"
    subscription_id = "sub_00000000-0000-0000-0000-000000000000"
    WebMock.stub(:get, "https://api.beehiiv.com/v2/publications/#{publication_id}/subscriptions/#{subscription_id}")
      .to_return(status: 200, body: File.read("spec/support/subscriptions_show.json"), headers: {"Content-Type" => "application/json"})

    client = Beehiiv.client
    subscription = Beehiiv::Subscription.retrieve(client, publication_id, id: subscription_id).data
    subscription.id.should eq(subscription_id)
  end
  it "updates a subscriber" do
    publication_id = "pub_00000000-0000-0000-0000-000000000000"
    subscription_id = "sub_00000000-0000-0000-0000-000000000000"
    WebMock.stub(:patch, "https://api.beehiiv.com/v2/publications/#{publication_id}/subscriptions/#{subscription_id}")
      .to_return(status: 200, body: File.read("spec/support/subscriptions_patch.json"), headers: {"Content-Type" => "application/json"})

    client = Beehiiv.client
    subscription = Beehiiv::Subscription.update(client, publication_id, id: subscription_id).data
    subscription.id.should eq(subscription_id)
  end
  it "deletes a subscriber" do
    publication_id = "pub_00000000-0000-0000-0000-000000000000"
    subscription_id = "sub_00000000-0000-0000-0000-000000000000"
    WebMock.stub(:delete, "https://api.beehiiv.com/v2/publications/#{publication_id}/subscriptions/#{subscription_id}")
      .to_return(status: 204, body: "", headers: {"Content-Type" => "application/json"})

    client = Beehiiv.client
    response = Beehiiv::Subscription.delete(client, publication_id, id: subscription_id)
    response.should eq(true)
  end
end
