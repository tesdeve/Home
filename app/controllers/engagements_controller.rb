class EngagementsController < ApplicationController
  before_action :authenticate_user!
  #before_action  :set_admin
  before_action :set_engagement, only: [:show, :edit, :update, :destroy]
  before_action :set_building  #, except: [:index]
  before_action :set_user, except: [:index]


  def index
      @building = Building.find(params[:building_id])     
    #@building = @engagements.engagement.building_id
      @engagements = @building.engagements

  end


  def show
  end


  def new
    @engagement  = @building.engagement.build
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
          format.html { redirect_to building_engagements_path(@building), notice: 'Engagement was successfully created.' }
          format.json { render :show, status: :created, location: @engagement }
        else
          format.html { render :new }
          format.json { render json: @engagement.errors, status: :unprocessable_entity }
        end
      end
  end

  def update
    #if set_admin
      respond_to do |format|
        if @engagement.update(engagement_params)
          format.html { redirect_to building_engagement_path(@building), notice: 'Engagement was successfully updated.' }
          format.json { render :show, status: :ok, location: @engagement }
        else
          format.html { render :edit }
          format.json { render json: @engagement.errors, status: :unprocessable_entity }
        end
      end
  end

  def destroy
    @engagement.destroy
    respond_to do |format|
      format.html { redirect_to  building_engagements_path(@building), notice: 'Engagement was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_engagement
      #@engagement = Building.engagements.find(params[:id])
      #@engagement = Engagement.find(params[:id])
      @building = Building.find(params[:building_id])

      @engagement = @building.engagements.find(params[:id])
    end

    def set_admin
      current_user.admin?
    end

    def set_building
       @building = Building.find(params[:building_id]) || @engagement.building_id
      #@building = @engagement.building_id
    end

    def set_user
     @user = User.find(params[:user_id])  
    end


    # Only allow a list of trusted parameters through.
    def engagement_params
      params.require(:engagement).permit(:building_id, :user_id, :role, :started_at, :ended_at)
    end
end
