class ElectionDateAndDeadlineLoader
  attr_reader :transformed_data
  def initialize(transformed_data)
    @transformed_data = transformed_data
  end

  def save
    transformed_data["attributes"].map do |voting_option|
      create_voting_option(voting_option)
    end
  end

  def state
    state_name = transformed_data["state"].downcase
    State.where(name: state_name).first
  end

  def election
    @election ||= Election.first_or_create(
      jurisdiction_id: state.id,
      jurisdiction_type: "state",
      election_type: transformed_data["election_type"],
      election_date: transformed_data["election_date"]
    )
  end

  def create_voting_option(hsh)
    VotingOption.first_or_create(
      election_id: election.id,
      voting_type: hsh["type"],
      dates_and_deadlines: hsh["dates_and_deadlines"]
    )
  end
end
