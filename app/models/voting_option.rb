class VotingOption < ActiveRecord::Base
  # include Virtus.model

  # class DateWithMetadata
  # end

  belongs_to :election

  validates :voting_type, presence: true
  # validate  :deadlines_are_valid

  # attribute :voting_type,         String
  # attribute :dates_and_deadlines, Hash[String => DateWithMetadata], default: {}

  private
  # def deadlines_are_valid
  #   dates_and_deadlines.each do |key, date|
  #     # unless date.is_a?
  #   end
  # end
end
