require "rails_helper"

RSpec.describe StateBuilder do
  let(:stater_voter_information) { File.read(Rails.root.join('spec/fixtures/state_voter_information_directionary.html')) }
    let(:state_codes) { File.read(Rails.root.join('spec/fixtures/state_codes.html')) }

  before do
      stub_request(:get, "https://www.usvotefoundation.org/vote/sviddomestic.htm")
        .to_return(body: stater_voter_information)
      stub_request(:get, "https://en.wikipedia.org/wiki/List_of_states_and_territories_of_the_United_States")
        .to_return(body: state_codes)
  end

  describe "#build" do
    it "increases states, but doesn't duplicate" do
      expect {StateBuilder.new.build}.to change(State, :count).by(55)
    end
  end
end
