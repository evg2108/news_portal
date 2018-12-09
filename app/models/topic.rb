class Topic < ApplicationRecord
  belongs_to :event
  has_many :posts

  validates :title, presence: true
  validates :description, presence: true
  validates :event_id, presence: true
end
