class EventTagsController < ApplicationController
  before_action :set_event_tag, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource


  # GET /event_tags
  # GET /event_tags.json
  def index
    @event_tags = EventTag.all
  end

  # GET /event_tags/1
  # GET /event_tags/1.json
  def show
  end

  # GET /event_tags/new
  def new
    @event_tag = EventTag.new
  end

  # GET /event_tags/1/edit
  def edit
  end

  # POST /event_tags
  # POST /event_tags.json
  def create
    @event_tag = EventTag.new(event_tag_params)

    respond_to do |format|
      if @event_tag.save
        format.html { redirect_to @event_tag, notice: 'Event tag was successfully created.' }
        format.json { render :show, status: :created, location: @event_tag }
      else
        format.html { render :new }
        format.json { render json: @event_tag.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /event_tags/1
  # PATCH/PUT /event_tags/1.json
  def update
    respond_to do |format|
      if @event_tag.update(event_tag_params)
        format.html { redirect_to @event_tag, notice: 'Event tag was successfully updated.' }
        format.json { render :show, status: :ok, location: @event_tag }
      else
        format.html { render :edit }
        format.json { render json: @event_tag.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /event_tags/1
  # DELETE /event_tags/1.json
  def destroy
    @event_tag.destroy
    respond_to do |format|
      format.html { redirect_to event_tags_url, notice: 'Event tag was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event_tag
      @event_tag = EventTag.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_tag_params
      params.require(:event_tag).permit(:event_id, :tag_id)
    end
end
