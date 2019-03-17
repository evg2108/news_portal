class NewEventMarkUpdater
  attr_reader :user

  def initialize(user)
    @user = user
  end

  def update!(event_id)
    event = Event.find(event_id)
    user.update(last_notified_event_id: event.id)
  end
end