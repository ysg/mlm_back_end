require 'spec_helper'
include Capybara::DSL

describe "user rdegister" do
  it "redirects directs to the right page" do
    user = FactoryGirl.create(:identity)
    visit "identities/new"
    click_link "Register"

    page.should have_content("Package")
  end
end