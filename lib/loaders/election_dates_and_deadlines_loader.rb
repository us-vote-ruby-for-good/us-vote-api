class ElectionDateAndDeadlineLoader
  attr_reader :transformed_data
  def initialize(transformed_data)
    @transformed_data = transformed_data
  end

  def save
    transformed_data.map do |hsh|
      if hsh["state"]
        EDDLoader.new(hsh).save
      end
    end
  end

  class EDDLoader
    attr_reader :hsh
    def initialize(hsh)
      @hsh = hsh
    end

    def save
      election
      hsh["attributes"].map do |voting_option|
        create_voting_option(voting_option)
      end
    end

    def state
      state_name = hsh["state"].downcase
      State.where(name: state_name).first
    end

    def election
      Election.find_or_create_by(
        jurisdiction_id: state.id,
        jurisdiction_type: "state",
        election_type: hsh["election_type"],
        election_date: hsh["election_date"]
      )
    end

    def create_voting_option(attributes)
      # VotingOption.find_or_create_by(
      #   election_id: election.id,
      #   voting_type: attributes["type"],
      # )
    end
  end
end
