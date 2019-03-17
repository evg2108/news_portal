class NewEventMarksController < ApplicationController
  def update
    updater = NewEventMarkUpdater.new(current_user)
    updater.update!(params[:id])

    head :ok
  end
end