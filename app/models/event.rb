class Event < ApplicationRecord
  include IdentifiedSearch

  belongs_to :place
  has_and_belongs_to_many :tags, join_table: 'events_tags'
  has_many :topics

  delegate :city, :city_id, to: :place, allow_nil: true

  validates :title, presence: true
  validates :description, presence: true
  validates :begin_time, presence: true
  validates :end_time, presence: true
  validates :place_id, presence: true

  after_create :broadcast_notification

  def tag_names
    tags.pluck(:name)
  end

  def tag_names=(tags_list)
    tags_list = tags_list.map(&:presence).compact.map(&:downcase)

    found_tags = Tag.where(name: tags_list).to_a
    found_tag_names = found_tags.map(&:name)

    not_found_tag_names = tags_list - found_tag_names
    new_tags = not_found_tag_names.map{ |tag_name| Tag.new(name: tag_name) }

    self.tags = found_tags + new_tags
  end

  def id_string
    "#{city.name} / #{place.title} / #{title}"
  end

  def suitable_filter_ids
    filters = Filter.joins(:user)
                .where('users.last_notified_event_id < ?', id)
                .where('begin_interval < :begin_time or end_interval > :begin_time or (begin_interval is null and end_interval is null)', begin_time: begin_time)
                .where('city_id = ? or city_id is null', city_id)
    filters = filters.where('tag_id in (?)', tags.ids) if tags.any?
    filters.uniq.pluck(:id)
  end

  private

  def broadcast_notification
    return if begin_time < Time.now

    ActionCable.server.broadcast('application_cable:new_event_channel_all',
                                 filter_ids: suitable_filter_ids, event_id: id)
  end
end
