class MemberEventsController < ApplicationController
  before_action :set_member_event, only: %i[show edit update destroy]

  # GET /member_events or /member_events.json
  def index
    @member_events = MemberEvent.all
  end

  # GET /member_events/1 or /member_events/1.json
  def show; end

  # GET /member_events/new
  def new
    @member_event = MemberEvent.new
  end

  # GET /member_events/1/edit
  def edit; end

  # POST /member_events or /member_events.json
  def create
    @member_event = MemberEvent.new(member_event_params)

    respond_to do |format|
      if @member_event.save
        format.html { redirect_to(member_event_url(@member_event), notice: 'Member event was successfully created.') }
        format.json { render(:show, status: :created, location: @member_event) }
      else
        format.html { render(:new, status: :unprocessable_entity) }
        format.json { render(json: @member_event.errors, status: :unprocessable_entity) }
      end
    end
  end

  # PATCH/PUT /member_events/1 or /member_events/1.json
  def update
    respond_to do |format|
      if @member_event.update(member_event_params)
        format.html { redirect_to(member_event_url(@member_event), notice: 'Member event was successfully updated.') }
        format.json { render(:show, status: :ok, location: @member_event) }
      else
        format.html { render(:edit, status: :unprocessable_entity) }
        format.json { render(json: @member_event.errors, status: :unprocessable_entity) }
      end
    end
  end

  # DELETE /member_events/1 or /member_events/1.json
  def destroy
    @member_event.destroy

    respond_to do |format|
      format.html { redirect_to(member_events_url, notice: 'Member event was successfully destroyed.') }
      format.json { head(:no_content) }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_member_event
    @member_event = MemberEvent.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def member_event_params
    params.require(:member_event).permit(:user_id, :event_id, :date, :time_spent)
  end
end
