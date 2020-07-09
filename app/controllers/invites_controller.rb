class InvitesController < ApplicationController
  before_action :set_invite, only: [:show, :edit, :update, :destroy]

  # GET /invites
  # GET /invites.json
  def index
    @invites = Invite.all
  end

  # GET /invites/1
  # GET /invites/1.json
  def show
  end

  # GET /invites/new
  def new
    @invite = Invite.new
  end

  # GET /invites/1/edit
  def edit
  end

  # POST /invites
  # POST /invites.json
#  def create
#    @invite = Invite.new(invite_params)
#    @invite.sender_id = current_user.id
#    @invite.save
#    puts("Building ID : #{@invite.building_id}")
#    if @invite.save 
#    puts("Building ID : #{@invite.building_id}")   
#    puts(@invite)
#
#    InviteMailer.new_user_invite(@invite, new_user_registration_url(:invite_token => @invite.token)).deliver
#    flash[:message] = "Invitacion enviada!!"
#    redirect_to root_path
#    else 
#      flash.now[:error] = @invite.errors.full_messages
#      puts ""
#      puts(" No invite found")
#      puts ""
#      redirect_to root_path
#      #render :new
#    end
#  end
#


  def create
    @invite = Invite.new(invite_params)
    @invite.sender_id = current_user.id
    
    @invite.save
    if @invite.save    
      #  #if the user already exists
       if @invite.recipient != nil
         puts("")
         puts("") 
         puts("Recipient : #{@invite.recipient}")
         puts("")
         puts("")
         puts("Sender : #{@invite.sender}")
        #send a notification email
         InviteMailer.existing_user_invite(@invite).deliver 
  
         #Add the user to the organization
         @invite.recipient.buildings.push(@invite.building)
         redirect_to buildings_path
      else
         InviteMailer.new_user_invite(@invite, new_user_registration_path(:invite_token => @invite.token)).deliver
         redirect_to buildings_path
      end
      else
        puts ("NO INVITE FOUND")
        redirect_to root_path
         # oh no, creating an new invitation failed
      end

  end

      #if @invite.save
      #  format.html { redirect_to @invite, notice: 'Invite was successfully created.' }
      #  format.json { render :show, status: :created, location: @invite }
      #else
      #  format.html { render :new }
      #  format.json { render json: @invite.errors, status: :unprocessable_entity }
      #end
   # end
  #end

  # PATCH/PUT /invites/1
  # PATCH/PUT /invites/1.json
  def update
    respond_to do |format|
      if @invite.update(invite_params)
        format.html { redirect_to @invite, notice: 'Invite was successfully updated.' }
        format.json { render :show, status: :ok, location: @invite }
      else
        format.html { render :edit }
        format.json { render json: @invite.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /invites/1
  # DELETE /invites/1.json
  def destroy
    @invite.destroy
    respond_to do |format|
      format.html { redirect_to invites_url, notice: 'Invite was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_invite
      @invite = Invite.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def invite_params
      params.require(:invite).permit(:email, :token, :sender_id, :recipient_id, :building_id, :accepted)
    end
end
