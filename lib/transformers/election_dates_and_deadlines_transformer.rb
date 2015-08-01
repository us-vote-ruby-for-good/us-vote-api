class ElectionDatesAndDeadlinesTransformer
  attr_reader :dates_and_deadlines
  def initialize(dates_and_deadlines)
    @dates_and_deadlines = dates_and_deadlines
  end

  def transform
    filtered_dates_and_deadlines.map do |date_and_deadline|
      ElectionDateAndDeadlineTransformer.new(date_and_deadline).to_hash
    end
  end

  def filtered_dates_and_deadlines
    dates_and_deadlines.select do |date_and_deadline|
      date_and_deadline["election_date"]
    end
  end
end
