module Api
  class ElectionSerializer < ActiveModel::Serializer
    attributes :election_type,
               :election_date,
               :voting_options

    def voting_options
      object.voting_options.map do |option|
        {
          voting_type:         option.voting_type,
          dates_and_deadlines: option.dates_and_deadlines
        }
      end
    end
  end
end