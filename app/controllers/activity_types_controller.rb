# frozen_string_literal: true

class ActivityTypesController < ApplicationController
     before_action :set_activity_type, only: %i[show edit update destroy]
     before_action :check_if_not_pleb
     # GET /activity_types or /activity_types.json
     def index
          @activity_types = ActivityType.all
     end

     # GET /activity_types/1 or /activity_types/1.json
     def show; end

     # GET /activity_types/new
     def new
          @activity_type = ActivityType.new
     end

     # GET /activity_types/1/edit
     def edit; end

     # POST /activity_types or /activity_types.json
     def create
          @activity_type = ActivityType.new(activity_type_params)

          respond_to do |format|
               if @activity_type.save
                    format.html { redirect_to(activity_type_url(@activity_type), notice: 'Activity type was successfully created.') }
                    format.json { render(:show, status: :created, location: @activity_type) }
               else
                    format.html { render(:new, status: :unprocessable_entity) }
                    format.json { render(json: @activity_type.errors, status: :unprocessable_entity) }
               end
          end
     end

     # PATCH/PUT /activity_types/1 or /activity_types/1.json
     def update
          respond_to do |format|
               if @activity_type.update(activity_type_params)
                    format.html { redirect_to(activity_type_url(@activity_type), notice: 'Activity type was successfully updated.') }
                    format.json { render(:show, status: :ok, location: @activity_type) }
               else
                    format.html { render(:edit, status: :unprocessable_entity) }
                    format.json { render(json: @activity_type.errors, status: :unprocessable_entity) }
               end
          end
     end

     # DELETE /activity_types/1 or /activity_types/1.json
     def destroy
          @activity_type.destroy!

          respond_to do |format|
               format.html { redirect_to(activity_types_url, notice: 'Activity type was successfully destroyed.') }
               format.json { head(:no_content) }
          end
     end

     private

     # Use callbacks to share common setup or constraints between actions.
     def set_activity_type
          @activity_type = ActivityType.find(params[:id])
     end

     # Only allow a list of trusted parameters through.
     def activity_type_params
          params.require(:activity_type).permit(:name, :description)
     end

     def check_if_not_pleb
          current_user = User.find_by(email: session[':useremail'])
          redirect_to(root_path, alert: 'Not authorized') if current_user.nil? || !(current_user.check_admin || current_user.check_platoon_leader)
     end
end
