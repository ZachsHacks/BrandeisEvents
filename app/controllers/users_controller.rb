require 'icalendar'

class UsersController < ApplicationController
  before_action :logged_in?
	skip_before_action :verify_authenticity_token

  def get_events
    @active_tab = params[:index].to_i
    respond_to do |format|
      format.js
    end
  end

  def show
    @user = User.find(params[:id])
    redirect_to root_path if @user != current_user
  end

  def creation_form
    @user = User.find(params[:id])
    redirect_to root_path if @user != current_user
  end

  def to_icalendar
    @user = User.find(params[:calendar_hash])
    respond_to do |format|
      format.html
      format.ics do
        cal = Icalendar::Calendar.new
        @user.events.each do |e|
          event = Icalendar::Event.new
          event.dtstart = e.start
          # adds hour for now for ending time
          event.dtend = e.start + 1 * 60 * 60
          event.summary = e.name
          event.uid = event.url = "http://BrandeisEvents.herokuapp.com/events/#{e.id}"
          event.location = e.location
          event.description = e.description_text
          cal.add_event(event)
        end
        cal.publish
        render text: cal.to_ical
      end
    end
  end

  # GET /users/new
  def new
    @user = User.new
    authorize! :new, @user
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
    authorize! :edit, @user
		respond_to do |format|
			format.html
			format.js
		end
  end

  # POST /users
  # POST /users.json
  def create
		user_params["phone"] = user_params["phone"].gsub!(/[^0-9A-Za-z]/, '') if user_params["phone"]
    @user = User.new(user_params)
    respond_to do |format|
      if @user.save
        format.html { redirect_to new_account_path }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    @user = User.find(params[:id])
    authorize! :update, @user
		user_params["phone"] = user_params["phone"].gsub!(/[^0-9A-Za-z]/, '') if user_params["phone"]
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html
        format.json { render json: @user.errors, status: :unprocessable_entity }
				format.js
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    authorize! :destroy, @user
    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :bio, :is_host, :phone, :street, :city, :zip_code, :state, :text_time_num, :text_time_unit, :email_time_num, :email_time_unit)
  end
end
