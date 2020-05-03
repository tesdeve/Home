class RegistrationsController < Devise::RegistrationsController

  private

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