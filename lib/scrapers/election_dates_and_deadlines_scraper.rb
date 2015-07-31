require 'wombat'

class ElectionDatesAndDeadlinesScraper
  include Wombat::Crawler

  base_url "https://www.usvotefoundation.org"
  path  "/vote/state-elections/state-election-dates-deadlines.htm"

  table_rows "css= table tbody tr", :iterator do
    election_name css: "td:first-child"
    election_date css: "td:nth-child(2)"
    voter_registration css: "td:nth-child(3)"
    absentee_ballot_request css: "td:nth-child(4)"
    absentee_ballot_return css: "td:nth-child(5)"
    early_in_person_voting css: "td:nth-child(6)"
  end
end

