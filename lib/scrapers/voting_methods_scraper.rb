require 'wombat'

class VotingMethodsScraper 
  include Wombat::Crawler

  base_url "https://www.usvotefoundation.org"
  path "/vote/state-elections/state-voting-laws-requirements.htm"

  table_rows({xpath: "//table/tbody/tr"}, :iterator) {
    state 'css=strong'
    early_in_person_voting css: 'td:nth-child(2)'
    no_excuse_absentee_voting css: 'td:nth-child(3)'
    absentee_voting_with_excuse css: 'td:nth-child(4)'
    all_mail_voting css: 'td:nth-child(5)'
    voter_id_on_election_day css: 'td:nth-child(6)'
    same_day_voter_registration css: 'td:nth-child(7)'
  }
end

# State | Early In-Person Voting | No Excuse Absentee Voting 
# All-Mail Voting | Voter ID on Election Day | Same Day Voter Registration