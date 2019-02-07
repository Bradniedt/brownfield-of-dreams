class InviteMailer < ApplicationMailer
  def inform(email, user, invitee)
    @user = user
    @invitee = invitee
    binding.pry
    mail(to: email, subject: "Sign up for Brownfield Tutorials")
  end
end
