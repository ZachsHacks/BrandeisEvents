require 'icalendar'
class UsersController < ApplicationController
    before_action :logged_in?
    # load_and_authorize_resource

    def get_events
        @active_tab = params[:index].to_i
        respond_to do |format|
            format.js
        end
    end

    # GET /users/1
    # GET /users/1.json
    def show
        @user = User.find(params[:id])
        redirect_to root_path if @user != current_user
    end

    def creation_form
        @user = User.find(params[:id])
        redirect_to root_path if @user != current_user
    end

    def to_icalender
        @user = User.find(params[:id])
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
                    event.uid = event.url = "http://campusnow.herokuapp.com/events#{e.id}"
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
        authorize! :new
    end

    # GET /users/1/edit
    def edit
        @user = User.find(params[:id])
        authorize! :edit, @user
    end

    # POST /users
    # POST /users.json
    def create
        @user = User.new(user_params)
        respond_to do |format|
            if @user.save
                format.html { redirect_to new_account_path, notice: 'User was successfully created.' }
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
        respond_to do |format|
            if @user.update(user_params)
                format.html { redirect_to @user, notice: 'User was successfully updated.' }
                format.json { render :show, status: :ok, location: @user }
            else
                format.html { render :edit }
                format.json { render json: @user.errors, status: :unprocessable_entity }
            end
        end
    end

    # DELETE /users/1
    # DELETE /users/1.json
    def destroy
        @user.destroy
        authorize! :destroy, @user
        respond_to do |format|
            format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
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
        params.require(:user).permit(:first_name, :last_name, :email, :bio, :is_host, :phone, :street, :city, :zip_code, :state)
    end
end
