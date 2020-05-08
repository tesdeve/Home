class EngagementsController < ApplicationController
  before_action :authenticate_user!
  before_action  :set_admin
  before_action :set_engagement, only: [:show, :edit, :update, :destroy]
  before_action :set_building, except: [:index]
  before_action :set_user, except: [:index]

  # GET /engagements
  # GET /engagements.json
  def index
    #@building = @engagements.engagement.building_id
    if set_admin
      @engagements = Engagement.all
    else
      redirect_to root_path
    end
  end

  # GET /engagements/1
  # GET /engagements/1.json
  def show
    if !set_admin
      redirect_to root_path
    end
  end

  # GET /engagements/new
  def new
    if set_admin
      @engagement = Engagement.new
    else
      redirect_to root_path
    end
  end

  # GET /engagements/1/edit
  def edit
    if !set_admin
      redirect_to root_path
    end
  end

  # POST /engagements
  # POST /engagements.json
  def create
    if set_admin
      @engagement = Engagement.new(engagement_params)
      #@building = Building.find(params[:id])
      #@engagement = @building.engagements.create(params[:engagement].permit(:building_id, :user_id, :role))

      respond_to do |format|
        if @engagement.save
          format.html { redirect_to @engagement, notice: 'Engagement was successfully created.' }
          format.json { render :show, status: :created, location: @engagement }
        else
          format.html { render :new }
          format.json { render json: @engagement.errors, status: :unprocessable_entity }
        end
      end
    else
      redirect_to root_path
    end
  end

  # PATCH/PUT /engagements/1
  # PATCH/PUT /engagements/1.json
  def update
    if set_admin
      respond_to do |format|
        if @engagement.update(engagement_params)
          format.html { redirect_to @engagement, notice: 'Engagement was successfully updated.' }
          format.json { render :show, status: :ok, location: @engagement }
        else
          format.html { render :edit }
          format.json { render json: @engagement.errors, status: :unprocessable_entity }
        end
      end
    else
      redirect_to root_path
    end
  end

  # DELETE /engagements/1
  # DELETE /engagements/1.json
  def destroy
    @engagement.destroy
    respond_to do |format|
      format.html { redirect_to engagements_url, notice: 'Engagement was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_engagement
      @engagement = Engagement.find(params[:id])
    end

    def set_admin
      current_user.admin?
    end

    def set_building
      @building = @engagement.building_id
    end

    def set_user
      @user = @engagement.user_id
    end

    # Only allow a list of trusted parameters through.
    def engagement_params
      params.require(:engagement).permit(:building_id, :user_id, :role, :started_at, :ended_at)
    end
end
