class ContactinfosController < ApplicationController
  before_action :set_contactinfo, only: [:show, :edit, :update, :destroy]

  def index
    @contactinfos = Contactinfo.all
  end


  def show
  end

  def new
    @contactinfo = Contactinfo.new
  end


  def edit
  end


  def create
    @contactinfo = Contactinfo.new(contactinfo_params)

    respond_to do |format|
      if @contactinfo.save
        format.html { redirect_to @contactinfo, notice: 'Contactinfo was successfully created.' }
        format.json { render :show, status: :created, location: @contactinfo }
      else
        format.html { render :new }
        format.json { render json: @contactinfo.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @contactinfo.update(contactinfo_params)
        format.html { redirect_to @contactinfo, notice: 'Contactinfo was successfully updated.' }
        format.json { render :show, status: :ok, location: @contactinfo }
      else
        format.html { render :edit }
        format.json { render json: @contactinfo.errors, status: :unprocessable_entity }
      end
    end
  end


  def destroy
    @contactinfo.destroy
    respond_to do |format|
      format.html { redirect_to contactinfos_url, notice: 'Contactinfo was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_contactinfo
      @contactinfo = Contactinfo.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def contactinfo_params
      params.require(:contactinfo).permit(:contactable_id, :contactable_type, :telefono, :email, :mobile)
    end
end
