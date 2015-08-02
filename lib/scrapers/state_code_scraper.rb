class StateCodeScraper
  include Wombat::Crawler
  base_url "https://en.wikipedia.org"
  path  "/wiki/List_of_states_and_territories_of_the_United_States"

  states "css=table.wikitable tr", :iterator do
    name css: "th a"
    code css: "td"
  end
end
