class StateTransformer
  attr :state_drupal_ids, :state_codes
  def initialize(state_drupal_ids, state_codes)
    @state_drupal_ids = state_drupal_ids
    @state_codes = state_codes
  end

  def transform
    all_states = filtered_state_drupal_ids + filtered_state_codes
    all_states.group_by { |hsh| hsh["name"] }.each_with_object([]) do |(key, values), array|
      array << if values[0] && values[1]
        values[0].merge values[1]
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
