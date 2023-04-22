require "../../spec_helper"

describe Beehiiv::Segment do
  it "retrieves information about all segments belonging to a specific publication" do
    publication_id = "pub_00000000-0000-0000-0000-000000000000"
    WebMock.stub(:get, "https://api.beehiiv.com/v2/publications/#{publication_id}/segments")
      .to_return(status: 200, body: File.read("spec/support/segments_index.json"), headers: {"Content-Type" => "application/json"})

    segments = Beehiiv::Segment.list(publication_id)
    segments.first.id.should eq("seg_00000000-0000-0000-0000-000000000000")
  end

  it "retrieves a Segment belonging to a specific publication" do
    publication_id = "pub_00000000-0000-0000-0000-000000000000"
    segment_id = "seg_00000000-0000-0000-0000-000000000000"
    WebMock.stub(:get, "https://api.beehiiv.com/v2/publications/#{publication_id}/segments/#{segment_id}")
      .to_return(status: 200, body: File.read("spec/support/segments_show.json"), headers: {"Content-Type" => "application/json"})

    segment = Beehiiv::Segment.retrieve(publication_id, id: segment_id).data
    segment.id.should eq(segment_id)
  end

  it "deletes a Segment. Deleting the segment does not affect the subscriptions in the segment." do
    publication_id = "pub_00000000-0000-0000-0000-000000000000"
    segment_id = "seg_00000000-0000-0000-0000-000000000000"
    WebMock.stub(:delete, "https://api.beehiiv.com/v2/publications/#{publication_id}/segments/#{segment_id}")
      .to_return(status: 204, body: "", headers: {"Content-Type" => "application/json"})

    response = Beehiiv::Segment.delete(publication_id, id: segment_id)
    response.should eq(true)
  end

  it "lists the subscriber ids from the most recent calculation of a specific publication" do
    publication_id = "pub_00000000-0000-0000-0000-000000000000"
    segment_id = "seg_00000000-0000-0000-0000-000000000000"
    WebMock.stub(:get, "https://api.beehiiv.com/v2/publications/#{publication_id}/segments/#{segment_id}/results")
      .to_return(status: 200, body: File.read("spec/support/segments_expand_results.json"), headers: {"Content-Type" => "application/json"})

    subscription_ids = Beehiiv::Segment.expand_results(publication_id, id: segment_id).data
    subscription_ids.should be_a(Array(String))
  end
end
