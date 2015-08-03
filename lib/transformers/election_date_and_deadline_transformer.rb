class ElectionDateAndDeadlineTransformer
  attr_reader :date_and_deadline
  def initialize(date_and_deadline)
    @date_and_deadline = date_and_deadline
  end

  def to_hash
    {
      "election_type" => election_type,
      "election_date" => election_date,
      "state" => state_name,
      "attributes" => parse_attributes(date_and_deadline)
    }
  end

  def state_name
    states_names.find do |state_name|
      date_and_deadline["election_name"].start_with?(state_name)
    end
  end

  def states_names
    StateBuilder.new.build if State.all.empty?
    @states_names = State.all.pluck(:name).map(&:titleize)
  end

  def election_type
    key = election_types.keys.find do |election_type|
      date_and_deadline["election_name"].include?(election_type)
    end
    election_types[key]
  end

  def election_types
    {
      "Special Primary Election" => "special primary",
      "Special Congressional Election" => "special congressional",
      "Special Election" => "special",
      "Primary Election" => "primary",
      "General Election" => "general"
    }
  end

  def election_date
    Chronic.parse(date_and_deadline["election_date"]).to_date

  end

  def parse_attributes(date_and_deadline)
    attributes = []
    unless date_and_deadline["early_in_person_voting"].empty?
      early_in_person_voting_hash = { "type" => "early in person voting" }
      if chronic = Chronic.parse(date_and_deadline["early_in_person_voting"])
        early_in_person_voting_hash["dates_and_deadlines"] = chronic.to_date
      end
      attributes << early_in_person_voting_hash
    end
    attributes
  end
end
