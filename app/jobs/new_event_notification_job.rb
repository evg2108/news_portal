class NewEventNotificationJob < ApplicationJob
  def perform(event)
    broadcast_for_active_users(event)

  end

  private

  def broadcast_for_active_users(event)
    ActionCable.server.broadcast('application_cable:new_event_channel_all',
                                 filter_ids: suitable_filter_ids(event))
  end

  def suitable_filter_ids(event)
    filters_finder = SuitableEventFiltersFinder.new(event)
    filters_finder.find_filters.pluck(:id)
  end
end