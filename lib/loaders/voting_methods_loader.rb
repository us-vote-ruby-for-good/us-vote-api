class VotingMethodsLoader 

end

scraped = VotingMethodsScraper.new.crawl

transformed = VotingMethodsTransformer.new(scraped)

p transformed.state_hash
