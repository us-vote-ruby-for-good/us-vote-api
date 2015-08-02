class StateTransformer
  attr :state_drupal_ids, :state_codes
  def initialize(state_drupal_ids, state_codes)
    @state_drupal_ids = state_drupal_ids
    @state_codes = state_codes
  end

  def transform
    all_states = filtered_state_drupal_ids + filtered_state_codes
    all_states.partition { |hsh| hsh["name"] }.map do |hshs|
      if hshs[0] && hshs[1]
        hshs[0].merge(hshs[1])
      end
    end.compact
  end

  def filtered_state_codes
    state_codes.select do |state_code|
      state_code["code"].present? && state_code["code"].length == 2
    end
  end

  def filtered_state_drupal_ids
    state_drupal_ids.select do |drupal_id|
      drupal_id["drupal_id"].to_i > 0 && !drupal_id["name"].start_with?("-")
    end
  end

end
