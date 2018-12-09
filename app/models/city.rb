class City < ApplicationRecord
  include IdentifiedSearch

  has_many :places

  validates :name, presence: true, uniqueness: true

  def id_string
    name
  end
end
