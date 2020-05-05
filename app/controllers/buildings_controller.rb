class BuildingsController < ApplicationController
  before_action :authenticate_user!
  before_action  :set_admin
  before_action :set_building, only: [:show, :edit, :update, :destroy]


  # GET /buildings
  # GET /buildings.json
  def index
    if set_admin
      @buildings = Building.all
    else
      redirect_to root_path
    end
  end

  # GET /buildings/1
  # GET /buildings/1.json
  def show

  end

  # GET /buildings/new
  def new
    if set_admin
      @building = Building.new
    else
      redirect_to root_path
    end
  end

  # GET /buildings/1/edit
  def edit
    if !set_admin
      redirect_to root_path
    end
  end

  # POST /buildings
  # POST /buildings.json
  def create
    if set_admin
   
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
    else
      redirect_to root_path
    end
  end

  # PATCH/PUT /buildings/1
  # PATCH/PUT /buildings/1.json
  def update
    if !set_admin
     redirect_to root_path
    else
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
  end

  # DELETE /buildings/1
  # DELETE /buildings/1.json
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
