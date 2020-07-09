class RegistrationsController < Devise::RegistrationsController

def new
 @user = User.new
   @token = params[:invite_token] #<-- pulls the value from the url query string
   puts("")
   puts("")
  puts (" THIS IS INVITE_TOKENL:  #{params[:invite_token]}")
   puts("")
   puts("")
 end



  def create       
    @user = User.new(user_params)
    @token = params[:invite_token] #<-- pulls the value from the url query string
    respond_to do |format|
      if @user.save
        if @token != nil && @token != ""
          building =  Invite.find_by_token(@token).building #find the organization attached to the invite
          @user.buildings.push(building) #add this user to the new organization as a member
        end


        format.html { redirect_to root_path, notice: 'Favor revise su correo para confirmar cuenta' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end




  private

  def user_params
     params.require(:user).permit(:email, :password, :password_confirmation, :terms) 
  end 

  def sign_up_params
    params.require(:user).permit(:email, :password, :password_confirmation, :terms) 
    # I could add the other fields if needed/wanted
  end

  def account_update_params
    params.require(:user).permit(:name, :lastname, :username, :email, :password, 
                                 :password_confirmation, :current_password, :role, :telephone)
  end
end

#contactinfo_attributes: [:telephone]



#def new
#   @token = params[:invite_token] #<-- pulls the value from the url query string
##   puts("")
##   puts("")
#   puts (" THIS IS INVITE_TOKENL:  #{params[:invite_token]}")
##   puts("")
##   puts("")
# end
##
#def create
# # @token = params[:invite_token] #<-- pulls the value from the url query string
#  @newUser = build_user(user_params)
#  #@newUser.save
#  @token = params[:invite_token]
#  puts(" TOKEEEEN #{@token}" )
#  @newUser.save
#  puts("WE ARE IN CREATE USER #{ @token}")
#    if @token != nil
#      puts(" TOKEEEEN #{@token}" )
#      building =  Invite.find_by_token(@token).building #find the organization attached to the invite
#        puts(" TOKEEEEN #{building}" )
#       @newUser.buildings.push(building) #add this user to the new organization as a member
#    else
#      pust( " ESTA CALLENDO AQUI!!!")
#      sign_up_params
#      # do normal registration things #
#    end
#end




#def create
# @token = params[:invite_token] #<-- pulls the value from the url query string
# puts(" TOKEEEEN1 #{@token}" )
#  puts("" )
#   puts("" )
# puts(" User Params : #{params[:user]}" )
#  puts("" )
# puts("" )
# puts(" User Params Funcion  : #{user_params}" )
#
# @newUser = User.new(user_params)
# #@newUser = build_user(user_params)
# @newUser.save
# #@token = params[:invite_token]
# puts(" TOKEEEEN1a #{@token}" )
#
# puts("WE ARE IN CREATE USER #{ @token}")
#   if @token != nil
#     puts(" TOKEEEEN #{@token}" )
#     building =  Invite.find_by_token(@token).building #find the organization attached to the invite
#       puts(" TOKEEEEN #{building}" )
#      @newUser.buildings.push(building) #add this user to the new organization as a member
#   else
#     pust( " ESTA CALLENDO AQUI!!!")
#     sign_up_params
#     # do normal registration things #
#   end
#end