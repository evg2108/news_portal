class Tag < ApplicationRecord
  include IdentifiedSearch

  has_and_belongs_to_many :events, join_table: 'events_tags'

  validates :name, presence: true

  def id_string
    name
  end
end
