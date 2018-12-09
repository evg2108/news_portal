module ApplicationCable
  class NewEventChannel < ActionCable::Channel::Base
    def subscribed
      stream_from "application_cable:new_event_channel_#{params[:room]}"
    end
  end
end
