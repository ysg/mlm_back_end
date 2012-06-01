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
		@root = User.create
		@child = @root.children.create
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
		u = @root.children.create
		@root.children.should include (u)
		u.parent.should == (@root)
	end

	it 'should allow to search for grandsons' do
		u = @child.children.create
		@root.descendants(:at_depth => 2).should == ([u])
	end
end
#specs for public methods
	
describe User, "Validations" do
end


