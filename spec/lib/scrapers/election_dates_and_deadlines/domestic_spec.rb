require "rails_helper"

RSpec.describe ElectionDatesAndDeadlinesScraper::Domestic do
  describe "#crawl" do
    let(:dates_and_deadlines) { File.read(Rails.root.join('spec/fixtures/election_dates_and_deadlines_domestic.html')) }
    let(:crawled_data) { @crawled_data ||= ElectionDatesAndDeadlinesScraper::Domestic.new.crawl["table_rows"] }
    let(:alabama_header) { crawled_data[0] }
    let(:alaska_primary_election) { crawled_data[4] }

    before do
      stub_request(:get, "https://www.usvotefoundation.org/vote/state-elections/state-election-dates-deadlines.htm")
        .to_return(:status => 200, :body => dates_and_deadlines, :headers => {})
    end

    it "headers have empty fields" do
      expect(alabama_header["election_name"]).to eq("Alabama (more info)")
      expect(alabama_header["election_date"]).to eq(nil)
      expect(alabama_header["voter_registration"]).to eq(nil)
      expect(alabama_header["absentee_ballot_request"]).to eq(nil)
      expect(alabama_header["asbentee_ballot_return"]).to eq(nil)
      expect(alabama_header["early_in_person_voting"]).to eq(nil)
    end

    it "election fields have the following fields" do
      expect(alaska_primary_election["election_name"]).to eq("Alaska Primary Election")
      expect(alaska_primary_election["election_date"]).to eq("August 16, 2016")
      expect(alaska_primary_election["voter_registration"]).to eq("July 17, 2016")
      expect(alaska_primary_election["absentee_ballot_request"]).to eq("August 6, 2016")
      expect(alaska_primary_election["asbentee_ballot_return"]).to eq(nil)
      expect(alaska_primary_election["early_in_person_voting"]).to eq("Beginning August 1, 2016")
    end
  end
end
