class UsersController < ApplicationController

def new
   @token = params[:invite_token] #<-- pulls the value from the url query string
   puts("")
   puts("")
   puts (" THIS IS INVITE_TOKENL:  #{params[:invite_token]}")
   puts("")
   puts("")
 end


 def create
  # @token = params[:invite_token] #<-- pulls the value from the url query string
   @newUser = build_user(user_params)
   #@newUser.save
   @token = params[:invite_token]
   @newUser.save
   puts("WE ARE IN CREATE USER #{ @token}")
     if @token != nil
       puts(" TOKEEEEN #{@token}" )
       building =  Invite.find_by_token(@token).building #find the organization attached to the invite
         puts(" TOKEEEEN #{building}" )
        @newUser.buildings.push(building) #add this user to the new organization as a member
     else
       pust( " ESTA CALLENDO AQUI!!!")
       # do normal registration things #
     end
 end

end



#def new
#    @token = params[:invite_token] #<-- pulls the value from the url query string
#    puts("")
#     puts("")
#    puts (" THIS IS INVITE_TOKENL:  #{params[:invite_token]}")
#     puts("")
#      puts("")
# end

# def create
#  # @token = params[:invite_token] #<-- pulls the value from the url query string
#   @newUser = build_user(user_params)
#   @newUser.save
#   @token = params[:invite_token]
#   puts("WE ARE IN CREATE USER #{ @token}")
#     if @token != nil
#       puts(" TOKEEEEN #{@token}" )
#       building =  Invite.find_by_token(@token).building #find the organization attached to the invite
#         puts(" TOKEEEEN #{building}" )
#        @newUser.buildings.push(building) #add this user to the new organization as a member
#     else
#       pust( " ESTA CALLENDO AQUI!!!")
#       # do normal registration things #
#     end
# end