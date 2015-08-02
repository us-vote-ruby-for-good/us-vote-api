module Api
  class ElectionSerializer < ActiveModel::Serializer
    attributes :election_type,
               :election_date
  end
end