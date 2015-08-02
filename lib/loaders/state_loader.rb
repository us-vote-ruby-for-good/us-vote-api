class StateLoader
  attr_reader :states
  def initialize(states)
    @states = states
  end

  def save
    states.each do |state|
      State.first_or_create(
        code: state["code"].downcase,
        drupal_id: state["drupal_id"].to_i,
        name: state["name"].downcase
      )
    end
  end
end
