class BuildingsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_building, only: [:show, :edit, :update, :destroy]
 #before_action  :set_admin
  def index
    @user = User.find(current_user.id) 
    if @user
      @buildings = @user.buildings.distinct  
    end
  end

  def show
  end


  def new
    @building = Building.new
  end

  def edit
  end


  def create       
      @building = Building.new(building_params)
      #@building = current_user.buildings.build(building_params)
      respond_to do |format|
        if @building.save
          format.html { redirect_to @building, notice: 'Building was successfully created.' }
          format.json { render :show, status: :created, location: @building }
        else
          format.html { render :new }
          format.json { render json: @building.errors, status: :unprocessable_entity }
        end
      end
  end

  def update
    respond_to do |format|
      if @building.update(building_params)
        format.html { redirect_to @building, notice: 'Building was successfully updated.' }
        format.json { render :show, status: :ok, location: @building }
      else
        format.html { render :edit }
        format.json { render json: @building.errors, status: :unprocessable_entity }
      end
    end
  end


  def destroy
    @building.destroy
    respond_to do |format|
      format.html { redirect_to buildings_url, notice: 'Building was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_building
      @building = Building.find(params[:id])
    end

    def set_admin
      current_user.admin?
    end

    # Only allow a list of trusted parameters through.
    def building_params
      params.require(:building).permit(:name, :buildingtype, engagements_attributes: [:user_id, :building_id, :role, :started_at])  #, engagements_attributes: [:user_id, :building_id, :role]
    end
end
