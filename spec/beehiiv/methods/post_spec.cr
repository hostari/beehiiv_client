require "../../spec_helper"

describe Beehiiv::Post do
  it "retrieves all Posts belonging to a specific publication" do
    publication_id = "pub_00000000-0000-0000-0000-000000000000"
    post_id = "post_00000000-0000-0000-0000-000000000000"
    WebMock.stub(:get, "https://api.beehiiv.com/v2/publications/#{publication_id}/posts")
      .to_return(status: 200, body: File.read("spec/support/posts_index.json"), headers: {"Content-Type" => "application/json"})

    client = Beehiiv.client
    posts = Beehiiv::Post.list(client, publication_id)
    posts.first.id.should eq(post_id)
  end

  it "retrieves a Post belonging to a specific publication" do
    publication_id = "pub_00000000-0000-0000-0000-000000000000"
    post_id = "post_00000000-0000-0000-0000-000000000000"
    WebMock.stub(:get, "https://api.beehiiv.com/v2/publications/#{publication_id}/posts/#{post_id}")
      .to_return(status: 200, body: File.read("spec/support/posts_show.json"), headers: {"Content-Type" => "application/json"})

    client = Beehiiv.client
    post = Beehiiv::Post.retrieve(client, publication_id, id: post_id).data
    post.id.should eq(post_id)
  end

  # Deletes or archives a Post. Any post that has been confirmed will have its status changed to archived. Posts in the draft status will be permanently deleted.
  it "returns true when successfully deleting or archiving a Post" do
    publication_id = "pub_00000000-0000-0000-0000-000000000000"
    post_id = "post_00000000-0000-0000-0000-000000000000"
    WebMock.stub(:delete, "https://api.beehiiv.com/v2/publications/#{publication_id}/posts/#{post_id}")
      .to_return(status: 204, body: "", headers: {"Content-Type" => "application/json"})

    client = Beehiiv.client
    response = Beehiiv::Post.delete(client, publication_id, id: post_id)
    response.should eq(true)
  end
end
