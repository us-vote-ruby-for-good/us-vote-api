class ElectionDateAndDeadlineTransformer
  attr_reader :date_and_deadline
  def initialize(date_and_deadline)
    @date_and_deadline = date_and_deadline
  end

  def to_hash
    {
      "election_type" => parse_election_type(date_and_deadline["election_name"]),
      "election_date" => Chronic.parse(date_and_deadline["election_date"]).to_date,
      "state" => parse_state_name(date_and_deadline["election_name"])
    }
  end

  def parse_state_name(election_name)
    states_names.find do |state_name|
      election_name.start_with?(state_name)
    end
  end

  def states_names
    @states_names = ["Alabama", "Alaska", "West Virginia","Virginia", "Virgin Islands"] # State.all.pluck(:name)
  end

  def parse_election_type(election_name)
    key = election_types.keys.find do |election_type|
      election_name.include?(election_type)
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
end
