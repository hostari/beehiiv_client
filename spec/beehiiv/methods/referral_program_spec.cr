require "../../spec_helper"

describe Beehiiv::ReferralProgram do
  it "retrieves details about the publication's referral program, including milestones and rewards" do
    publication_id = "pub_00000000-0000-0000-0000-000000000000"
    WebMock.stub(:get, "https://api.beehiiv.com/v2/publications/#{publication_id}/referral_program")
      .to_return(status: 200, body: File.read("spec/support/referral_program_show.json"), headers: {"Content-Type" => "application/json"})

    referral_program = Beehiiv::ReferralProgram.retrieve(publication_id).data
    referral_program.first.id.should eq("mile_00000000-0000-0000-0000-000000000000")
  end
end
