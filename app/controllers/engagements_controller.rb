class EngagementsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_engagement, only: [:show, :edit, :update, :destroy]
  before_action :set_building
 

  def index
      @building = Building.find(params[:building_id])     
    #@building = @engagements.engagement.building_id

    if set_admin_access_rights
      @engagements = @building.engagements
    else
      respond_to do |format|
        format.html { redirect_to building_path(@building), alert: 'No tienes ACCESO.' }
      end
    end
  end


  def show
  end


  def new
    @engagement  = @building.engagements.build
    #@engagement = Engagement.new      
  end


  def edit
  end


  def create
    @engagement = Engagement.new(engagement_params) #\\\
      #@engagement = @building.engagement.build(engagement_params)
      #@engagement.building_id  = @building.id
      #@engagement.user_id = current_user.id #Temporarly while the form is improved
      
      respond_to do |format|
        if @engagement.save
          format.html { redirect_to building_engagements_path(@building), 
                        notice: 'Engagement was successfully created.' }
          format.json { render :show, status: :created, location: @engagement }
        else
          format.html { render :new }
          format.json { render json: @engagement.errors, status: :unprocessable_entity }
        end
      end
  end

  def update
    respond_to do |format|
      if @engagement.update(engagement_params)
        if check_one_admin_exist  
          format.html { redirect_to building_engagement_path(@building), 
                        notice: 'Engagement was successfully updated.' }
          format.json { render :show, status: :ok, location: @engagement }

        else
          format.html { redirect_to edit_building_engagement_path(@building), 
                        alert: '333 No puedes borrar al único Administrador. Debe existir mínimo un Administrador. ' }  
          format.json { render json: @engagement.errors, status: :unprocessable_entity }
        end
      else
        format.html { redirect_to edit_building_engagement_path(@building), 
                        alert: 'Usuario ya tiene engagement con este role. Puedes asignar otro role.' }  
        format.json { render json: @engagement.errors, status: :unprocessable_entity }

      end
    end
  end

 def destroy
   if on_delete_check_one_admin_exist
     redirect_to building_engagements_path(@building), 
           alert: 'No puedes borrar al único Administrador. Debe existir mínimo un Administrador.  '   
   else
    @engagement.destroy
    redirect_to building_engagements_path(@building),  notice: 'Engagement was successfully destroyed.'
    end
 end
 

private
  def set_engagement
    @building = Building.find(params[:building_id])
    @engagement = @building.engagements.find(params[:id])
  end

  def set_admin
    @building = Building.find(params[:building_id])
    if current_user.id.present? && @engagement.role == 'admin'
      true
    end
  end

  def set_building
     @building = Building.find(params[:building_id]) || @engagement.building_id
  end

  # There always be at least one user with role Admin\ 
  def on_delete_check_one_admin_exist   
    @engagement = Engagement.find(params[:id])
    @engagements = Engagement.where(building_id: @building.id, role: "admin"  )      
    if @engagements.count == 1  && @engagement.role == 'admin'
     true
    end
  end

  #Might no be needed as the (on_delete_check_one_admin_exist) mehtod ensures that there is always one. 
 def check_one_admin_exist
   #@building = Building.find(params[:building_id])
   @engagements = Engagement.where(building_id: @building.id, role: "admin"  )
   if @engagements.count > 0
    true
   end
 end

  # Check the User has the Correct Access Rigth and ensures that at least one Admin exist
  def set_admin_access_rights
    #@building = Building.find(params[:building_id])
    @engagements = Engagement.where(building_id: @building.id, user_id: current_user.id, role: "admin"  )
    if @engagements.count > 0
     true
    end
  end
  # Only allow a list of trusted parameters through.
  def engagement_params
    params.require(:engagement).permit(:building_id, :user_id, :role, :started_at, :ended_at, :creator)
  end
end
