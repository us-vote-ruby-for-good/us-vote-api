class StateBuilder
  def build
    state_drupal_ids = StateScraper.new.crawl["states"]
    state_codes = StateCodeScraper.new.crawl["states"]
    transformed_data = StateTransformer.new(state_drupal_ids, state_codes).transform
    StateLoader.new(transformed_data).save
  end
end
