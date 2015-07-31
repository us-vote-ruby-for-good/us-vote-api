json.array!(@admin_states) do |admin_state|
  json.extract! admin_state, :id, :name, :code, :drupal_id
  json.url admin_state_url(admin_state, format: :json)
end
