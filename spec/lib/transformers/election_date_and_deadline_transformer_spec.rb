require "rails_helper"

RSpec.describe ElectionDateAndDeadlineTransformer do
  let(:election_dates_and_deadlines) { {
    "election_name" => "Alaska Primary Election",
    "election_date" => "August 16, 2016",
    "voter_registration" => "July 17, 2016",
    "absentee_ballot_request" => "August 6, 2016",
    "asbentee_ballot_return" => nil,
    "early_in_person_voting" => "Beginning August 1, 2016"
  }}
  let(:transformer) {ElectionDateAndDeadlineTransformer.new(election_dates_and_deadlines) }

  let(:dates_and_deadlines_to_hash) {
    {
      "state" => "Alaska",
      "election_date" => Date.new(2016, 8, 16),
      "election_type" => "primary"
    }
  }

  describe "#to_hash" do
    it "matches desired hash" do
      expect(transformer.to_hash).to eq(dates_and_deadlines_to_hash)
    end
  end

  describe "#parse_state_name" do
    it "parses Virginia" do
      expect(transformer.parse_state_name("Virginia Primary Election")).to eq("Virginia")
    end
    it "parses West Virginia" do
      expect(transformer.parse_state_name("West Virginia Primary Election")).to eq("West Virginia")
    end
    it "parses Virgin Islands" do
      expect(transformer.parse_state_name("Virgin Islands Primary Election")).to eq("Virgin Islands")
    end
  end

  describe "#parse_election_type" do
    it "parses a primary election type" do
      expect(transformer.parse_election_type("Alaska Primary Election")).to eq("primary")
    end

    it "parses a general election type" do
      expect(transformer.parse_election_type("Florida General Election")).to eq("general")
    end

    it "parses a special primary election type" do
      expect(transformer.parse_election_type("Illinois Special Primary Election")).to eq("special primary")
    end

    it "parses a special congressional election type" do
      expect(transformer.parse_election_type("New York Special Congressional Election, 11th Congressional District")).to eq("special congressional")
    end

    it "parses a special congressional election type" do
      expect(transformer.parse_election_type("District of Columbia Special Election: Ward 4 and Ward 8")).to eq("special")
    end
  end
end
