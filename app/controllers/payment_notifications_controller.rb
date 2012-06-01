class PaymentNotificationsController < ApplicationController
  protect_from_forgery :except => [:create]

  def index
    @payments = current_user.payment_notifications
  end

  def create
    #puts"-------------------- payment_notification----------------------"
    #puts params.inspect
    #puts"-----------------------pn end----------------------------------"
    PaymentNotification.create!(:params => params, :user_id => params[:custom], :status => params[:payment_status], :transaction_id => params[:txn_id])
    render :nothing => true
  end
end
