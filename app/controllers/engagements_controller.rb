class EngagementsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_engagement, only: [:show, :edit, :update, :destroy]
  before_action :set_building
 

  def index
      @building = Building.find(params[:building_id])     
    #@building = @engagements.engagement.building_id

    if set_admin_access_rights
      @engagements = @building.engagements.order('created_at DESC')
    else
      respond_to do |format|
        format.html { redirect_to building_path(@building), alert: 'No tienes ACCESO.' }
      end
    end
  end


  def show
    set_engagement_editor
  end


  def new
    @engagement  = @building.engagements.build
    #@engagement = Engagement.new      
  end


  def edit
    set_creator
    associated_user
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
    set_creator
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
           alert: 'No puedes borrar al único usuario con acceso de Administrador. Debe existir mínimo un Administrador.  '   
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
    if current_user.id.present? && @engagement.access == 'admin'
      true
    end
  end

  def set_building
     @building = Building.find(params[:building_id]) || @engagement.building_id
  end

  # There always be at least one user with role Admin\ 
  def on_delete_check_one_admin_exist   
    @engagement = Engagement.find(params[:id])
    @engagements = Engagement.where(building_id: @building.id, access: "admin" )      
    if @engagements.count == 1  
     true
    end
  end

  #Might no be needed as the (on_delete_check_one_admin_exist) mehtod ensures that there is always one. 
 def check_one_admin_exist
   #@building = Building.find(params[:building_id])
   @engagements = Engagement.where(building_id: @building.id, access: "admin"  )
   if @engagements.count > 0
    true
   end
 end

  def associated_user
    @associated_user = @engagement.user.email.split('@')[0].titleize 
  end

  # Check the User has the Correct Access Rigth and ensures that at least one Admin exist
  def set_admin_access_rights
    #@building = Building.find(params[:building_id])
    #@engagement = Engagement.find(params[:id])
    #@engagements = Engagement.where(building_id: @building.id, user_id: current_user.id, access: "admin", role: "administrador" ) || Engagement.where(building_id: @building.id, user_id: current_user.id, access: "admin", role: "consejo"  )
    #if @engagements.count > 0
    # true
    #end
    engagements1 = Engagement.where(building_id: @building.id, user_id: current_user.id, access: "admin", role: "administrador" )
    engagements2 = Engagement.where(building_id: @building.id, user_id: current_user.id, access: "admin", role: "consejo"  )

    if ( engagements1.count > 0 || engagements2.count > 0 )    
     true
    end
  end


  def set_creator
    @engagement = Engagement.find(params[:id])
    @creator = User.find(@engagement.creator)
  end

  def set_engagement_editor
    @engagement = Engagement.find(params[:id])
    if @engagement.edited_by != nil 
      @editor = User.find(@engagement.edited_by)
    end 
  end

  # Only allow a list of trusted parameters through.
  def engagement_params
    params.require(:engagement).permit(:building_id, :user_id, :access, :role, :started_at, :ended_at, :creator, :edited_by)
  end
end
