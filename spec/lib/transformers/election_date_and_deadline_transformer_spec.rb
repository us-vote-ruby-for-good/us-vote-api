require "rails_helper"

RSpec.describe ElectionDateAndDeadlineTransformer do
  let(:election_name) { "Alaska Primary Election" }
  let(:election_dates_and_deadlines) { {
    "election_name" => election_name,
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
      "election_type" => "primary",
      "attributes" => [
        {
          "type" => "early in person voting",
          "start_date" => Date.new(2016, 8, 1)
        }
      ]
    }
  }

  describe "#to_hash" do
    it "matches desired hash" do
      expect(transformer.to_hash).to eq(dates_and_deadlines_to_hash)
    end
  end

  describe "#parse_state_name" do
    describe "For Virigina Primary Election" do
      let(:election_name) { "Virginia Primary Election" }
      it "returns Virginia" do
        expect(transformer.state_name).to eq("Virginia")
      end
    end

    describe "For West Virigina Primary Election" do
      let(:election_name) { "West Virginia Primary Election" }
      it "returns West Virginia" do
        expect(transformer.state_name).to eq("West Virginia")
      end
    end

    describe "For Virgin Islands Primary Election" do
      let(:election_name) { "Virgin Islands Primary Election" }
      it "return Virgin Islands" do
        expect(transformer.state_name).to eq("Virgin Islands")
      end
    end
  end

  describe "#parse_election_type" do
    it "parses a primary election type" do
      expect(transformer.election_type).to eq("primary")
    end

    describe "It parses General Elections" do
      let(:election_name) { "Florida General Election" }
      it "returns general" do
        expect(transformer.election_type).to eq("general")
      end
    end

    describe "It parses Special Primary Election" do
      let(:election_name) { "Illinois Special Primary Election" }
      it "returns special primary" do
        expect(transformer.election_type).to eq("special primary")
      end
    end

    describe "It parses Special Congressional Election" do
        let(:election_name) { "New York Special Congressional Election, 11th Congressional District" }
      it "returns special congressional" do
        expect(transformer.election_type).to eq("special congressional")
      end
    end

    describe "It parse Special Election" do
      let(:election_name) { "District of Columbia Special Election: Ward 4 and Ward 8" }

      it "returns special" do
        expect(transformer.election_type).to eq("special")
      end
    end
  end
end
