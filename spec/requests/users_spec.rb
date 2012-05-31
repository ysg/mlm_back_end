require 'spec_helper'

describe "Users" do

  describe "GET /users" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
			credentials = ActionController::HttpAuthentication::Basic.encode_credentials('andy','thering')
      get users_path, nil, {'HTTP_AUTHORIZATION' =>  credentials }

      response.status.should be(200)
    end

    it "requires authentication" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get users_path
      response.status.should be(401)
    end
  end

end