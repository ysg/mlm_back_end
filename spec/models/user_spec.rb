# == Schema Information
#
# Table name: users
#
#  id             :integer         not null, primary key
#  provider       :string(255)
#  uid            :string(255)
#  name           :string(255)
#  company        :string(255)
#  spouse_name    :string(255)
#  street_address :string(255)
#  city           :string(255)
#  state          :string(255)
#  zip            :string(255)
#  ein            :string(255)
#  home_phone     :string(255)
#  cell           :string(255)
#  email          :string(255)
#  package        :integer
#  referred_by    :string(255)
#  referer_id     :integer
#  created_at     :datetime        not null
#  updated_at     :datetime        not null
#  ancestry       :string(255)
#  ancestry_depth :integer         default(0)
#  purchased_at   :datetime
#

require 'spec_helper'

describe User, "Ancestry features" do
  before(:each) do
    User.destroy_all
    Identity.destroy_all
    @identity = FactoryGirl.create(:identity)
    @root = FactoryGirl.create(:user, :name => @identity.name, :email => @identity.email, :uid =>@identity.id.to_s)
    @child = @root.children.create! do |user|
        user.name ="child"
        user.email = "childd1@child.com"
        user.package = "3"
        user.referer_id = "1"
        user.street_address = "street"
        user.city = "city"
        user.state = "state"
        user.zip = "zip"
        user.home_phone = "1111111"
    end
    @valid_attributes = {
    }
  end

	it 'should have children' do
		@root.children.should == ([@child])
	end

	it 'should have parent' do
		@child.parent.should == (@root)
	end

	it 'should allow to create new children' do
		u = @root.children.create! do |user|
        user.name ="child"
        user.email = "child2@child.com"
        user.package = "3"
        user.referer_id = "1"
        user.street_address = "street"
        user.city = "city"
        user.state = "state"
        user.zip = "zip"
        user.home_phone = "1111111"
      end
		@root.children.should include (u)
		u.parent.should == (@root)
	end

	it 'should allow to search for grandsons' do
		u = @child.children.create! do |user|
        user.name ="child"
        user.email = "child11@child.com"
        user.package = "3"
        user.referer_id = "1"
        user.street_address = "street"
        user.city = "city"
        user.state = "state"
        user.zip = "zip"
        user.home_phone = "1111111"
      end
		@root.descendants(:at_depth => 2).should == ([u])
	end
end
#specs for public methods
	
describe User, "Validations" do
  before do
    User.destroy_all
    Identity.destroy_all
    @identity = FactoryGirl.create(:identity)
    @user = FactoryGirl.create(:user, :name => @identity.name, :email => @identity.email, :uid =>@identity.id.to_s)
  end

  subject { @user }

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:email) }
  it { should validate_uniqueness_of(:email) }
  it { should validate_presence_of(:street_address) }
  it { should validate_presence_of(:city) }
  it { should validate_presence_of(:state) }
  it { should validate_presence_of(:zip) }
  it { should validate_presence_of(:home_phone) }
  it { should validate_numericality_of(:home_phone) }
  it { should validate_numericality_of(:cell) }
  it { should validate_presence_of(:package) }
  it { should validate_presence_of(:referer_id) }
  #it { should validate_presence_of(:referred_by) }
end


