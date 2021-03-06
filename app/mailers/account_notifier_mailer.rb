class AccountNotifierMailer < ApplicationMailer
  def inform(user)
    @user = user
    mail(to: user.email, subject: "Activate Your Account")
  end
  def invite(email, user, invitee)
    @user = user.githubname
    @invitee = invitee
    mail(to: email, subject: "Sign up for Brownfield Tutorials")
  end
end
