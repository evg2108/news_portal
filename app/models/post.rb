class Post < ApplicationRecord
  belongs_to :user
  belongs_to :topic
  has_one :event, through: :topic

  validates :message, presence: true
  validates :user_id, presence: true
  validates :topic_id, presence: true
end
