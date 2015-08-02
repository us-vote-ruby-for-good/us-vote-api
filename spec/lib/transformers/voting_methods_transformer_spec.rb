require "rails_helper"

describe VotingMethodsTransformer do
  before { @stub = stub_request(:get, "https://www.usvotefoundation.org/vote/state-elections/state-voting-laws-requirements.htm")
      .to_return({:body => state_voting_laws_requirements}) }

  let(:state_voting_laws_requirements) { File.read(Rails.root + "spec/fixtures/state-voting-laws-requirements.html") }
  let(:voting_methods_dirty_hash) { @voting_methods_dirty_hash ||= VotingMethodsScraper.new.crawl }
  let(:data) { VotingMethodsTransformer.new(voting_methods_dirty_hash) } 
  let(:state_hash) { data.state_hash }

  it "prints the correct info per state" do 
    alabama_result = { 
      "early_in_person_voting"       => "none",
      "no_excuse_absentee_voting"    => "none",
      "absentee_voting_with_excuse"  => "yes",
      "all_mail_voting"              => "none",
      "voter_id_on_election_day"     => "Non-Strict Photo ID",
      "same_day_voter_registrations" => "none"
    }

    virginia_result = { 
      "early_in_person_voting"       => "none",
      "no_excuse_absentee_voting"    => "none",
      "absentee_voting_with_excuse"  => "yes",
      "all_mail_voting"              => "none",
      "voter_id_on_election_day"     => "Strict Photo ID\n                        Strict voter ID applies on Eelction Day and Absentee in Person Voting. See notes concerning same day voter registration for absent military and overseas voters.",
      "same_day_voter_registrations" => "none"
    }

   
    expect(data.retrieve_state_info("Alabama")).to eq alabama_result
    expect(data.retrieve_state_info("Virginia")).to eq virginia_result
  end

  it "removes blank spaces with an 'none' message" do 
    expect(data.humanize_values(state_hash)).not_to include(" ")
  end

  it "humanizes values containing a '✓'" do 
    expect(data.humanize_values(state_hash)).not_to include("✓")
  end
end
