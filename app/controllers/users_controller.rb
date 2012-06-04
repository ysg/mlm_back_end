class UsersController < ApplicationController
  http_basic_authenticate_with :name => "admin", :password => "bpbadmin", :only => [:index, :show]
  # GET /users
  # GET /users.json
  def index
    @users = User.page(params[:page]).per(10)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end

  def get_referer_name
    @user = User.find_by_referer_id(params[:referer_id])
    render json: @user.to_json(:only => [ :name, :referer_id ])
  end

  def upgrade_to_platinum
    redirect_to login_path and return if current_user.package==1

    current_package_cost = User::PACKAGE_COSTS[current_user.package.to_s]
    platinum_package_cost = User::PACKAGE_COSTS["1"]
    payment_amount = platinum_package_cost - current_package_cost
    redirect_to current_user.paypal_url(my_account_url, payment_notifications_url, payment_amount, "platinum")
  end

  def upgrade_to_gold
    redirect_to login_path and return if ( (current_user.package==1) || (current_user.package==2) )

    current_package_cost = User::PACKAGE_COSTS[current_user.package.to_s]
    gold_package_cost = User::PACKAGE_COSTS["2"]
    payment_amount = gold_package_cost - current_package_cost
    redirect_to current_user.paypal_url(my_account_url, payment_notifications_url, payment_amount, "gold")
  end

  # GET /users/1/edit
  def edit
    @user = current_user
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    @user = current_user
    @user.set_user_accessible_attributes(params[:user])
    @user.set_user_protected_attributes(params[:user])

    respond_to do |format|
      if @user.save
        @user.update_identity
        format.html { redirect_to my_account_url, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end


#  # GET /users/new
#  # GET /users/new.json
#  def new
#    @user = User.new(:parent_id => params[:referer_id])

#    respond_to do |format|
#      format.html # new.html.erb
#      format.json { render json: @user }
#    end
#  end

#  # POST /users
#  # POST /users.json
#  def create
#    @user = User.new(params[:user])

#    respond_to do |format|
#      if @user.save
#        format.html { redirect_to @user, notice: 'User was successfully created.' }
#        format.json { render json: @user, status: :created, location: @user }
#      else
#        format.html { render action: "new" }
#        format.json { render json: @user.errors, status: :unprocessable_entity }
#      end
#    end
#  end

#  # DELETE /users/1
#  # DELETE /users/1.json
#  def destroy
#    @user = User.find(params[:id])
#    @user.destroy

#    respond_to do |format|
#      format.html { redirect_to users_url }
#      format.json { head :no_content }
#    end
#  end
end
