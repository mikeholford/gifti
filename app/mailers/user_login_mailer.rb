class UserLoginMailer < ApplicationMailer

  default :from => 'login@gifti.club'

  # send a signup email to the user, pass in the user object that   contains the user's email address
  def send_magic_link(user)
    @user = user
    mail( :to => @user.email,
    :subject => 'Magic link' )
  end

end
