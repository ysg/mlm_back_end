class SessionsController < ApplicationController
  def new
  end

  def create
   session[:user_id] = nil
   user = User.from_omniauth(env["omniauth.auth"],params)
   session[:user_id] = user.id
   #Redirect to paypal if from signup
   if (/identit/.match(request.referer).present? && user.package!=3)
     redirect_to user.paypal_url(my_account_url, payment_notifications_url) and return
   end
   session["return_to"] = params[:return_to] if params[:return_to].present?
   if session["return_to"].present?
    return_page = session["return_to"]
    session["return_to"] = nil
    redirect_to return_page, notice: "Signed in!"
   else
    redirect_to my_account_url, notice: "Signed in!"
   end
  end

  def destroy
   session[:user_id] = nil
   redirect_to root_url, notice: "Signed out!"
  end

  def failure
   redirect_to login_path, alert: "Authentication failed, please try again."
  end
end
