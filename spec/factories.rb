FactoryGirl.define do
  factory :user do
    email 'test@example.com'
    password 'f4k3p455w0rd'

    # if needed
    # is_active true
  end
end