class NewEventNotificationJob < ApplicationJob
  def perform(event)
    broadcast_for_active_users(event)

  end

  private

  def broadcast_for_active_users(event)
    ActionCable.server.broadcast('application_cable:new_event_channel_all',
                                 event_id: event.id)
  end
end