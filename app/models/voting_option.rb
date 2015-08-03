class VotingOption < ActiveRecord::Base
  belongs_to :election

  validates :voting_type, presence: true

  after_initialize :set_defaults

  private
  def deadlines_are_valid
    dates_and_deadlines.each do |key, date|
      # unless date.is_a? 
    end      
  end

  def set_defaults
    if dates_and_deadlines.nil?
      self.dates_and_deadlines = {}
    end
  end
end
