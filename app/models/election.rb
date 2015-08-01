class Election < ActiveRecord::Base
  belongs_to :jurisdiction, polymorphic: true
  has_many   :voting_options

  validates :jurisdiction_id,   presence: true
  validates :jurisdiction_type, presence: true
  validates :election_type,     presence: true
  validates :election_date,     presence: true, uniqueness: { scope: :jurisdiction }
end
