require "rails_helper"

RSpec.describe ElectionDatesAndDeadlinesTransformer do
  let(:election_dates_and_deadlines) { {
    "election_name" => "Alaska Primary Election",
    "election_date" => "August 16, 2016",
    "voter_registration" => "July 17, 2016",
    "absentee_ballot_request" => "August 6, 2016",
    "asbentee_ballot_return" => nil,
    "early_in_person_voting" => "Beginning August 1, 2016"
  }}
  let(:dates_and_deadlines) { [ {}, election_dates_and_deadlines]}
  let(:transformed_data) { ElectionDatesAndDeadlinesTransformer.new(dates_and_deadlines).transform }

  it "removes objects without election dates" do
    expect(transformed_data.length).to eq(1)
  end

  it "maps to schema" do
    model = transformed_data.first
    expect(model["election_type"]).to eq("primary")
    expect(model["election_date"]).to eq(Date.new(2016,8,16))
    expect(model["state"]).to eq("Alaska")
  end
end
