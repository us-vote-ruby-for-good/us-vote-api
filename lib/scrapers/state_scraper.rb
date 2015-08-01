class StateScraper
  include Wombat::Crawler
  base_url "https://www.usvotefoundation.org"
  path  "/vote/sviddomestic.htm"

  states "css=select#select_state option", :iterator do
    name "xpath=.//."
    drupal_id "xpath=.//@value"
  end
end
