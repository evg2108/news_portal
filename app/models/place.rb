class Place < ApplicationRecord
  include IdentifiedSearch

  has_many :events
  belongs_to :city

  validates :city_id, presence: true
  validates :title, presence: true
  validates :description, presence: true

  def id_string
    "#{city.name} / #{title}"
  end
end
