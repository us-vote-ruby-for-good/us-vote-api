class ElectionDateAndDeadlineTransformer
  attr_reader :date_and_deadline
  def initialize(date_and_deadline)
    @date_and_deadline = date_and_deadline
  end

  def to_hash
    {
      "election_type" => election_type,
      "election_date" => Chronic.parse(date_and_deadline["election_date"]).to_date,
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
    @states_names = ["Alabama", "Alaska", "West Virginia","Virginia", "Virgin Islands"] # State.all.pluck(:name)
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

  def parse_attributes(date_and_deadline)
    attributes = []
    early_in_person_voting_hash = { "type" => "early in person voting" }
    early_in_person_voting_hash["start_date"] = Chronic.parse(date_and_deadline["early_in_person_voting"]).to_date
    [ early_in_person_voting_hash ]
  end
end
