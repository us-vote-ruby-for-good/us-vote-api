FactoryGirl.define do
  factory :election do
    election_type 'primary'
    election_date Time.now
  end
end