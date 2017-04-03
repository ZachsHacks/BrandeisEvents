
require './presenters/event_presenter'

class EventsController < ApplicationController
	before_action :set_event, only: [:show, :edit, :update, :destroy]

	def search
		@events = Event.search(params).paginate(page: params[:page], per_page: 9)
		grab_locations
	end

	# GET /events
	# GET /events.json
	def index
		@events = Event.paginate(page: params[:page], per_page: 9)
		grab_locations
	end

def home
	@items = Event.all.pluck(:name)
	@top_events =  Event.joins(:rsvps).order('choice desc')
	grab_locations

	if 	@top_events.count < 4
		@top_events = Event.all
	end
	@top_events = @top_events[0,4]

	# @top_tags = Tag.group(:name).order('name DESC').limit(5)
 @top_tags = Tag.all.limit(4)
end
	# GET /events/1
	# GET /events/1.json
	def show
		@tags = EventTag.where(event_id: @event.id)
	end

	# GET /events/new
	def new
		@event = Event.new
		@tags = ["religious", "clubs", "food", "academic", "sports"]
	end

	# GET /events/1/edit
	def edit

	end

	# POST /events
	# POST /events.json
	def create

		@event = Event.new(event_params)
		@presenter = EventPresenter.new(@event)

		respond_to do |format|
			if @event.save
				@presenter.create_tags(params)
				format.html { redirect_to @event, notice: 'Event was successfully created.' }
				format.json { render :show, status: :created, location: @event }
			else
				format.html { render :new }
				format.json { render json: @event.errors, status: :unprocessable_entity }
			end
		end
	end

	# PATCH/PUT /events/1
	# PATCH/PUT /events/1.json
	def update

		respond_to do |format|
			if @event.update(event_params)
				@presenter.update_tags(params)
				format.html { redirect_to @event, notice: 'Event was successfully updated.' }
				format.json { render :show, status: :ok, location: @event }
			else
				format.html { render :edit }
				format.json { render json: @event.errors, status: :unprocessable_entity }
			end
		end
	end

	# DELETE /events/1
	# DELETE /events/1.json
	def destroy
		@event.destroy
		respond_to do |format|
			format.html { redirect_to events_url, notice: 'Event was successfully destroyed.' }
			format.json { head :no_content }
		end
	end

	private
	# Use callbacks to share common setup or constraints between actions.
	def set_event
		@event = Event.find(params[:id])
		@presenter = EventPresenter.new(@event)
	end

	# Never trust parameters from the scary internet, only allow the white list through.
	def event_params
		params.require(:event).permit(:name, :description, :location, :start, :end, :price, :host_id, :event_image)
	end

	def grab_locations
		@locations = Location.all.pluck(:name)
	end

end
