class Filter < ApplicationRecord
  belongs_to :user

  belongs_to :city, optional: true
  belongs_to :tag, optional: true

  validates :user_id, presence: true
  validates :name, presence: true

  scope :suitable_by_city, ->(city_id) { where(arel_table[:city_id].eq(city_id).or(arel_table[:city_id].eq(nil)))  }
  scope :suitable_by_tag_ids, ->(tag_ids) { where(arel_table[:tag_id].in(tag_ids).or(arel_table[:tag_id].eq(nil)))  }

  scope :suitable_by_time, ->(event_beginning_time) {
    where(arel_table[:begin_interval].lt(event_beginning_time))
      .or(where(arel_table[:end_interval].gt(event_beginning_time)))
      .or(where(begin_interval: nil, end_interval: nil))
  }
end
