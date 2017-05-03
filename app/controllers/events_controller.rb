
require './presenters/event_presenter'
require 'active_support/core_ext'

class EventsController < ApplicationController
	before_action :set_event, only: [:show, :edit, :update, :destroy]

	#load_and_authorize_resource


	def search
		@events = Event.search(params).paginate(page: params[:page], per_page: 12)
		grab_locations
	end

	# GET /events
	# GET /events.json
	def index
		if params[:location]
			@events = Event.where("start > ? AND location LIKE ?", Time.now, params[:location]).paginate(page: params[:page], per_page: 12)
		elsif params[:date]
			@events = filter_dates(params[:date])
		elsif params[:tag]
			@events = filter_tags(params[:tag])
		else
			@events = Event.where("start > ?", Time.now).paginate(page: params[:page], per_page: 12)#Event.paginate(page: params[:page], per_page: 9)
		end
		grab_locations
	end

	def home
		#need caching
		all_events = Event.all
		@items = all_events.pluck(:name)
		@top_events =  all_events.sort_by{|e| e.rsvps_count}.last(4).reverse
		@locations = Location.all.pluck(:name)#grab_locations
		@top_tags = Tag.all.sort_by {|t| t.events_count}.last(7).reverse.map {|t| [t.events.count, t.name, t.id]}

	end
	# GET /events/1
	# GET /events/1.json
	def show
		@tags = EventTag.where(event_id: @event.id)
		@location = geolocation
		@current_latitude = request.location.latitude
		@current_longitude = request.location.longitude

		if @current_latitude == 0.0 || @current_longitude == 0.0
			#for localhost
			@current_latitude = 42.366239
			@current_longitude = -71.258469
		end


		# @current_latitude = 42.366239
		# @current_longitude = -71.258469
		geo_localization = "#{@current_latitude},#{@current_longitude}"
		@current_address = Geocoder.search(geo_localization).first.address

		@address = "#{@event.location}, Brandeis University, Waltham, MA, 02453"
	end

	def top_events
		@top_events =  Event.all.sort_by{|e| e.rsvps_count}.last(10).reverse.map {|e| [e.name, e.start, e.location]}

		respond_to do |format|
			format.html{}
			format.json{
				render json: @top_events.to_json}
			end
		end

		# GET /events/new
		def new
			@event = Event.new
			authorize! :new, @event
		end

		# GET /events/1/edit
		def edit
			authorize! :edit
		end

		# POST /events
		# POST /events.json
		def create

			@event = Event.new(event_params)
			@event.host = current_user
			@presenter = EventPresenter.new(@event)
			authorize! :create, @event
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
			authorize! :update
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
			authorize! :destroy
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
			params.require(:event).permit(:name, :description, :location, :start, :end, :price, :host_id, :event_image, :date, :tag)
		end

		def grab_locations
			db_locations = Location.all.pluck(:name).uniq
			active_locations = Event.all.pluck(:location).uniq
			@locations = db_locations && active_locations
		end

		def geolocation
			loc = []
			loc = Geocoder.coordinates("#{@event.location}, Brandeis University, Waltham, MA, 02453")
			loc = Geocoder.coordinates("Brandeis University, Waltham, MA, 02453") if loc.nil?
			return loc
		end

		def filter_tags(tag)
			Tag.find(tag).events.where("start > ?", Time.now).paginate(page: params[:page], per_page: 12)
		end

		def filter_dates(filter)
			if filter == "today"
				return Event.all.select {|e| e.start.to_date == Date.today}.paginate(page: params[:page], per_page: 12)
			elsif filter == "tomorrow"
				return Event.all.select {|e| e.start.to_date == Date.tomorrow}.paginate(page: params[:page], per_page: 12)
			elsif filter == "this week"
				return Event.all.select {|e| e.start.to_date.between?(Date.today,Date.today.next_day(7))}.paginate(page: params[:page], per_page: 12)
			elsif filter == "next week"
				return Event.all.select {|e| e.start.to_date.between?(Date.today.next_day(7),Date.today.next_day(14))}.paginate(page: params[:page], per_page: 12)
			elsif filter == "this weekend"
				return Event.all.select {|e| e.start.to_date.between?(Date.today, Date.today.next_day(7)) && e.start.to_date.on_weekend?}.paginate(page: params[:page], per_page: 12)
			else
				return Event.where("start < ?", Time.now).reverse.paginate(page: params[:page], per_page: 12)
			end
		end

	end
