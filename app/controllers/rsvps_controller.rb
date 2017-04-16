class RsvpsController < ApplicationController
  before_action :set_rsvp, only: [:show, :edit, :update, :destroy]
  skip_before_action :verify_authenticity_token

  # GET /rsvps
  # GET /rsvps.json
  def index
    @rsvps = Rsvp.all
  end

  # GET /rsvps/1
  # GET /rsvps/1.json
  def show
  end

  # GET /rsvps/new
  def new
    @rsvp = Rsvp.new
  end

  # GET /rsvps/1/edit
  def edit
  end

  # POST /rsvps
  # POST /rsvps.json
  def create
    @event = rsvp_params[:event_id]
    @rsvps = current_user.rsvps

    if has_rsvp?
      if @preexisting.choice == rsvp_params[:choice].to_i
        @preexisting.delete
      else
        @preexisting.update(rsvp_params)
      end
      redirect_to @preexisting.event
      return
    end

    @rsvp = Rsvp.new(rsvp_params)
    respond_to do |format|
      if @rsvp.save
        format.html { redirect_to @rsvp.event, notice: 'Rsvp was successfully created.' }
        format.json { render :show, status: :created, location: @rsvp }
      else
        format.html { render :new }
        format.json { render json: @rsvp.errors, status: :unprocessable_entity }
      end
    end
  end

  def rsvp
    @event = Event.find(rsvp_params[:event_id])
    @event_id = @event.id
    @rsvps = current_user.rsvps
    @choice = rsvp_params[:choice]

    if has_rsvp?
      @active = @preexisting.choice - 1
      if @preexisting.choice == @choice.to_i
        @preexisting.delete
      else
        @preexisting.update(rsvp_params)
      end
    else
      @active = 2
      Rsvp.create(rsvp_params)
    end

    respond_to do |format|
      format.js
    end
  end

  def has_rsvp?
    if @rsvps.pluck(:event_id).include?(@event.id.to_i)
      @preexisting = @rsvps.where(event: @event)[0]
      true
    else
      false
    end
  end

  # PATCH/PUT /rsvps/1
  # PATCH/PUT /rsvps/1.json
  def update
    respond_to do |format|
      if @rsvp.update(rsvp_params)
        format.html { redirect_to @rsvp, notice: 'Rsvp was successfully updated.' }
        format.json { render :show, status: :ok, location: @rsvp }
      else
        format.html { render :edit }
        format.json { render json: @rsvp.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rsvps/1
  # DELETE /rsvps/1.json
  def destroy
    @rsvp.destroy
    respond_to do |format|
      format.html { redirect_to rsvps_url, notice: 'Rsvp was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_rsvp
      @rsvp = Rsvp.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def rsvp_params
      params.permit(:user_id, :event_id, :choice)
    end
end
