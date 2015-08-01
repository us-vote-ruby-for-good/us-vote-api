class State < ActiveRecord::Base
  has_many :elections

  validates :code,      presence: true, uniqueness: true
  validates :name,      presence: true, uniqueness: true
  validates :drupal_id, presence: true, uniqueness: true

  def to_param
    code
  end
end
