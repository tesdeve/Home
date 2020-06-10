class BuildingsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_building, only: [:show, :edit, :update, :destroy]

  def index
    @user = User.find(current_user.id) 
    if @user
      #
      @buildings = @user.buildings.distinct.order('created_at DESC')  
    end
  end

  def show
  end


  def new
    @building = Building.new
  end

  def edit
    unless set_admin_user
     redirect_to buildings_path
    end
  end


  def create       
      @building = Building.new(building_params)
      #@building = current_user.buildings.build(building_params)
      respond_to do |format|
        if @building.save
          format.html { redirect_to @building, notice: 'Ente Residencial exitosamente creado!' }
          format.json { render :show, status: :created, location: @building }
        else
          format.html { render :new }
          format.json { render json: @building.errors, status: :unprocessable_entity }
        end
      end
  end

  def update
    if set_admin_user
      respond_to do |format|

        if @building.update(building_params)
          format.html { redirect_to @building, notice: 'Ente Residencial exitosamente editado!' }
          format.json { render :show, status: :ok, location: @building }
        else
          format.html { render :edit }
          format.json { render json: @building.errors, status: :unprocessable_entity }
        end
      end
    end
  end


  def destroy
    @building.destroy
    respond_to do |format|
      format.html { redirect_to buildings_url, notice: 'Ente Residencial exitosamente borrado!' }
      format.json { head :no_content }
    end
  end

  #def building_audit
  #  if @building 
  #end
#
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_building
      @building = Building.find(params[:id])
    end

    # If any of the engagements(role) for this User is Admin
    def set_admin_user
      @engagements = Engagement.where({building_id: @building.id, user_id: current_user.id, access: "admin"  })
      if @engagements.count > 0
       true
      end
    end


    # Only allow a list of trusted parameters through.
    def building_params
      params.require(:building).permit(:name, :buildingtype, engagements_attributes: [:creator, :edited_by, :user_id, :building_id, :access, :role, :started_at]) 
    end
end
