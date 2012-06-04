class PaymentNotificationsController < ApplicationController
  protect_from_forgery :except => [:create]

  def index
    @payments = current_user.payment_notifications
  end

  def create
    #puts"-------------------- payment_notification----------------------"
    #puts params.inspect
    #puts"-----------------------pn end----------------------------------"
    PaymentNotification.create!(:params => params, :user_id => params[:custom].split("-")[0], :status => params[:payment_status], :transaction_id => params[:txn_id])
    if(/package_signup/.match(params[:custom]).present?)
      u = User.find(params[:custom])
      u.package = 1 if(/platinum_package_signup/.match(params[:custom]).present?)
      u.package = 2 if(/gold_package_signup/.match(params[:custom]).present?)
      u.save
    end

    if(/package_upgrade/.match(params[:custom]).present?)
      u = User.find(params[:custom])
      u.package = 1 if(/platinum_package_upgrade/.match(params[:custom]).present?)
      u.package = 2 if(/gold_package_upgrade/.match(params[:custom]).present?)
      u.save
    end

    render :nothing => true
  end
end
