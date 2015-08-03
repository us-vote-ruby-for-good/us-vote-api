module Api
  class VotingOptionSerializer < ActiveModel::Serializer
    attributes :voting_type,
               :dates_and_deadlines
  end
end