class ElectionDatesAndDeadlinesBuilder
  def build
    StateBuilder.new.build
    election_dates = ElectionDatesAndDeadlinesScraper::Domestic.new.crawl["table_rows"]
    transformed_data = ElectionDatesAndDeadlinesTransformer.new(election_dates).transform
    ElectionDateAndDeadlineLoader.new(transformed_data).save
  end
end
