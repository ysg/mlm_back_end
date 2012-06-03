class PasswordResetsController < ApplicationController
  def new
  end

  def create
    identity = Identity.find_by_email(params[:email])
    identity.send_password_reset if identity
    redirect_to root_url, :notice => "Email sent with password reset instructions."
  end

  def edit
    begin
      @identity = Identity.find_by_password_reset_token!(params[:id])
    rescue
      redirect_to root_url, :alert => "Sorry, the url could not be validated"
    end
  end

  def update
    @identity = Identity.find_by_password_reset_token!(params[:id])
    user = User.find_by_email_and_uid(@identity.email,@identity.id.to_s)
    @identity.set_associated_user_attributes()
    @identity.password = params[:identity][:password]
    @identity.password_confirmation = params[:identity][:password_confirmation]
    @identity.password_reset_token = nil
    if @identity.password_reset_sent_at < 2.hours.ago
      redirect_to new_password_reset_path, :alert => "Password reset has expired."
    elsif @identity.save
      redirect_to root_url, :notice => "Password has been reset!"
    else
      render :edit
    end
  end
end
