require "rails_helper"

RSpec.describe ElectionDatesAndDeadlinesBuilder do
  let(:stater_voter_information) { File.read(Rails.root.join('spec/fixtures/state_voter_information_directionary.html')) }
  let(:state_codes) { File.read(Rails.root.join('spec/fixtures/state_codes.html')) }
  let(:dates_and_deadlines) { File.read(Rails.root.join('spec/fixtures/election_dates_and_deadlines_domestic.html')) }

  before do
    stub_request(:get, "https://www.usvotefoundation.org/vote/sviddomestic.htm")
      .to_return(body: stater_voter_information)
    stub_request(:get, "https://en.wikipedia.org/wiki/List_of_states_and_territories_of_the_United_States")
      .to_return(body: state_codes)
    stub_request(:get, "https://www.usvotefoundation.org/vote/state-elections/state-election-dates-deadlines.htm")
      .to_return(:status => 200, :body => dates_and_deadlines, :headers => {})
  end
  describe "#build" do
    it "increases states, elections and voting options" do
      # expect {ElectionDatesAndDeadlinesBuilder.new.build}.to change(State, :count).by(54)
      expect {ElectionDatesAndDeadlinesBuilder.new.build}.to change(Election, :count).by(98)
      # expect {ElectionDatesAndDeadlinesBuilder.new.build}.to change(VotingOption, :count).by(500)
    end
  end
end
