class Filter < ApplicationRecord
  belongs_to :user

  belongs_to :city, optional: true
  belongs_to :tag, optional: true

  validates :user_id, presence: true
  validates :name, presence: true

  class << self
    def search_all_new_events(user)
      user.filters.flat_map do |filter|
        filter.search_events.where('events.id > ?', user.last_notified_event_id).to_a
      end.uniq
    end
  end

  def search_events
    result_relation = Event.order(created_at: :desc)

    if city_id
      result_relation = result_relation.joins(place: :city).where(places: { city_id: city_id })
    end

    if tag_id
      result_relation = result_relation.joins(:tags).where(tags: { id: tag_id })
    end

    if begin_interval
      result_relation = result_relation.where('begin_time >= ?', begin_interval)
    end

    if end_interval
      result_relation = result_relation.where('begin_time <= ?', end_interval)
    end

    result_relation
  end

  def as_json(*)
    {
      'filter[city_id]' => city_id,
      'filter[tag_id]' => tag_id,
      'filter[begin_interval]' => begin_interval,
      'filter[end_interval]' => end_interval
    }
  end
end
