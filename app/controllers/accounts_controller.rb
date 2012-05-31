class AccountsController < ApplicationController
	before_filter :login_required
  def show
    @account = current_user

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end

	def user_modal
    @user = User.find(params[:user_id])
	  if request.xhr?
			render :partial => 'user_modal'
	  end
	end
end

