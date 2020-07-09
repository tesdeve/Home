class InviteMailer < ApplicationMailer

  def new_user_invite(invite, invite_token)
    @invite = invite

    mail(to: @invite.email, subject: "Authenticate your account")
  end

  def existing_user_invite(invite)
    @invite = invite
     mail(to: @invite.email, subject: "Invited to Participate")
  end

  
end
