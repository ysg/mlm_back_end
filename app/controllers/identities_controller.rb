class IdentitiesController < ApplicationController
  def new
    redirect_to my_account_url if current_user
    @identity = env['omniauth.identity']
    @user = User.new
    @identity.set_associated_user_attributes(params) if @identity.present?
    @user.set_user_accessible_attributes(params)
  end
end
