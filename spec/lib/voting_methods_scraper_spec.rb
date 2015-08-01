require 'rails_helper'

describe VotingMethodsScraper do
  describe "crawl" do  
    it "makes request to the US Vote Foundation website" do
      stub_request(:get, "https://www.usvotefoundation.org/vote/state-elections/state-voting-laws-requirements.htm")

      VotingMethodsScraper.new.crawl

      expect(WebMock).to have_requested(:get, "https://www.usvotefoundation.org/vote/state-elections/state-voting-laws-requirements.htm")
    end
  end

  describe "scrape" do 
    before { @stub = stub_request(:get, "https://www.usvotefoundation.org/vote/state-elections/state-voting-laws-requirements.htm")
        .to_return({:body => state_voting_laws_requirements}) }

    let(:state_voting_laws_requirements) { File.read(Rails.root + "spec/fixtures/state-voting-laws-requirements.html") }
    let(:crawled_data) { @crawled_data ||= VotingMethodsScraper.new.crawl }
    let(:alabama_data) { crawled_data["table_rows"][0] }
    let(:alaska_data)  { crawled_data["table_rows"][1] }

    it "scrapes for the state name" do
      expect(alabama_data["state"]).to eq("Alabama")
      expect(alaska_data["state"]).to eq("Alaska")
    end 

    it "scrapes for a state's early in-person voting option option" do 
      expect(alabama_data["early_in_person_voting"]).to include("")
      expect(alaska_data["early_in_person_voting"]).to include("✓")
    end

    it "scrapes for a state's absentee voting with excuse option" do 
      expect(alabama_data["absentee_voting_with_excuse"]).to include("✓")
      expect(alaska_data["absentee_voting_with_excuse"]).to include("")
    end

    it "scrapes for a state's all mail voting option" do 
      expect(alabama_data["all_mail_voting"]).to include("")
      expect(alaska_data["all_mail_voting"]).to include("")
    end

    it "scrapes for a state's voter id on election day requirement" do 
      expect(alabama_data["voter_id_on_election_day"]).to eq("Non-Strict Photo ID")
      expect(alaska_data["voter_id_on_election_day"]).to eq("Non-Strict, Non-Photo ID")
    end

    it "scrapes for a state's same day voter refistration option" do 
      expect(alabama_data["same_day_voter_registration"]).to include("")
      expect(alaska_data["same_day_voter_registration"]).to include("")
    end
  end
end
