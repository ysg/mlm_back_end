class AccountsController < ApplicationController

  def show
    @account = User.all.first

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end

end

