
require 'active_support/core_ext'

class EventsController < ApplicationController
	before_action :set_event, only: [:show, :edit, :update, :destroy]

	def search
		@events = Event.search(params).paginate(page: params[:page], per_page: 12)
		@locations = Location.all.select {|l| l.events.count > 0}
		respond_to do |format|
			format.html
			format.js
		end
	end

	# Get events based on search parameters
	def index
		@events = Event.where('start > ?', Time.now)
		@events = @events.sort_by { |e| e.start }.paginate(page: params[:page], per_page: 12)
		@locations = Location.all.select {|l| l.events.count > 0}
	end

	def filter_events
		@locations = Location.all.select {|l| l.events.count > 0}
		@events = []
		if params[:location]
			@events = Location.find_by(name: params[:location]).events.where('start > ?', Time.now)
		elsif params[:date]
			@events = filter_dates(params[:date])
		elsif params[:tag]
			@events = filter_tags(params[:tag])
		elsif params[:sponsor]
			search_phrase = search_by_sponsor(params[:sponsor].downcase)
			@events = Event.where("sponsor like ?", "%" + search_phrase + "%")
			@events = @events.where('start > ?', Time.now)


		else
			@events = Event.where('start > ?', Time.now)
		end
		@events = @events.sort_by { |e| e.start }.paginate(page: params[:page], per_page: 12)
		respond_to do |format|
			format.html
			format.js
		end
	end

	def home
		all_events = Event.where("start > ?", Time.now)
		@items = all_events.pluck(:name)
		@top_events = all_events.sort_by(&:rsvps_count).last(4).reverse
		@locations = Location.all.pluck(:name) # grab_locations
		@top_tags = Tag.all.sort_by(&:events_count).last(7).reverse.map { |t| [t.events.count, t.name, t.id, t.image] }
	end

	def show
		@tags = EventTag.where(event_id: @event.id)
		if !@lat_lng.nil?
			coordinates = @lat_lng.split('_')
			@current_latitude = coordinates[0]
			@current_longitude = coordinates[1]
		else
			# For local use, we hardcoded a test coordinate pair
			@current_latitude = 42.366365
			@current_longitude = -71.259591
		end
		@location = geolocation
		geo_localization = "#{@current_latitude},#{@current_longitude}"
		@current_address = Geocoder.search(geo_localization).first.address || "Brandeis University, Waltham, MA, 02453"
		@address = "#{@event.location}, Waltham, MA, 02453"
	end

	def top_events
		@top_events = Event.all.sort_by(&:rsvps_count).last(10).reverse.map { |e| [e.name, e.start, e.location] }

		respond_to do |format|
			format.html {}
			format.json do
				render json: @top_events.to_json
			end
		end
	end

	def top_events_on_day
		# for alexa and other chat bots as well as future integration with other apps
		date = params[:date].to_date.strftime('%m-%d-%Y').to_date
		@top_events = Event.where(start: date.beginning_of_day..date.end_of_day) if date.present?
		respond_to do |format|
			format.html {}
			format.json do
				render json: @top_events.to_json
			end
		end
	end

	# GET /events/new
	def new
		@event = Event.new
		authorize! :new, @event
	end


	# GET /events/1/edit
	def edit
		authorize! :edit, @event
	end


	# POST /events
	# POST /events.json
	def create
		@event = Event.new(event_params)
		@event.host = current_user
		authorize! :create, @event
		respond_to do |format|
			if @event.save
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
		authorize! :update, @event
		respond_to do |format|
			if @event.update(event_params)
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
		authorize! :destroy, @event
		respond_to do |format|
			format.html { redirect_to events_url, notice: 'Event was successfully destroyed.' }
			format.json { head :no_content }
		end
	end

	private

	# Use callbacks to share common setup or constraints between actions.
	def set_event
		@event = Event.find(params[:id])
	end

	# Never trust parameters from the scary internet, only allow the white list through.
	def event_params
		params.require(:event).permit(:name, :description, :location, :start, :end, :price, :host_id, :event_image, :date, :tag, :sponsor)
	end

	def geolocation
		loc = []
		loc = Geocoder.coordinates("#{@event.location}, Brandeis University, Waltham, MA, 02453")
		loc = Geocoder.coordinates('Brandeis University, Waltham, MA, 02453') if loc.nil?
		loc
	end

	def filter_tags(tag)
		Tag.find(tag).events.where('start > ?', Time.now)
	end

	def filter_dates(filter)
		if filter == 'today'
			Event.where(start: Time.now..Date.today.end_of_day)
		elsif filter == 'tomorrow'
			Event.where(start: Date.tomorrow.beginning_of_day..Date.tomorrow.end_of_day)
		elsif filter == 'this week'
			Event.where(start: Time.now.beginning_of_day..Date.today.next_day(7).end_of_day)
		elsif filter == 'next week'
			Event.where(start: Date.today.next_day(7).beginning_of_day..Date.today.next_day(14).end_of_day)
		elsif filter == 'this weekend'
			Event.where(start: Date.today.beginning_of_day..Date.today.next_day(7).end_of_day).select { |e| e.start.to_date.on_weekend? }
		else
			Event.where('start < ?', Time.now).reverse
		end
	end

	def search_by_sponsor(search_phrase)
		if search_phrase.include?("-")
			search_phrase = search_phrase.gsub("-", " ")
		end
	return search_phrase
end
end
