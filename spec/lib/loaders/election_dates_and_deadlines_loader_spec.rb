require "rails_helper"

RSpec.describe ElectionDateAndDeadlineLoader do
  let(:early_voting_hsh) {
        {
          "type" => "early in person voting",
          "dates_and_deadlines" => Date.new(2016, 8, 1)
        }
  }

  let(:transformed_data) {
    [{
      "state" => "Alaska",
      "election_date" => Date.new(2016, 8, 16),
      "election_type" => "primary",
      "attributes" => [
        early_voting_hsh
      ]
    }]
  }
  let(:loader) { ElectionDateAndDeadlineLoader.new(transformed_data) }
  let(:state) { FactoryGirl.create(:state, name: "alaska") }

  before do
    state
  end

  describe "#save" do
    it "increases elections and doesn't duplicate" do
      expect { loader.save }.to change(Election, :count).by(1)
      expect { loader.save }.to change(Election, :count).by(0)
    end

    it "increases votiing options" do
      # expect { loader.create_voting_option(early_voting_hsh) }.to change(VotingOption, :count).by(1)
    end
  end
end
