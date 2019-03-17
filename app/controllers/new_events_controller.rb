class NewEventsController < ApplicationController
  def index
    @searcher = NewFilteredUserEventsSearcher.new(current_user)
    @searcher.search
  end
end