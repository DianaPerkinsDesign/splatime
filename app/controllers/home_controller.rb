class HomeController < ApplicationController
  def index
  	@events = Event.active.order(:starts_at).to_a
    @active_event = @events.shift
  end
end
