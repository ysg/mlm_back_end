# == Schema Information
#
# Table name: identities
#
#  id              :integer         not null, primary key
#  name            :string(255)
#  email           :string(255)
#  password_digest :string(255)
#  created_at      :datetime        not null
#  updated_at      :datetime        not null
#

require 'spec_helper'

describe Identity, "Validations" do
  before do
    User.destroy_all
    Identity.destroy_all
    @identity = FactoryGirl.create(:identity)
  end

  subject { @identity }

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:email) }
  it { should validate_uniqueness_of(:email) }
  it { should_not allow_value("blah").for(:email) }
  it { should allow_value("testing@test.com").for(:email) }
  it { should validate_presence_of(:street_address) }
  it { should validate_presence_of(:city) }
  it { should validate_presence_of(:state) }
  it { should validate_presence_of(:zip) }
  it { should validate_presence_of(:home_phone) }
  it { should validate_numericality_of(:home_phone) }
  it { should validate_numericality_of(:cell) }
  it { should validate_presence_of(:package) }
  #it { should validate_presence_of(:referred_by) }
  it { should validate_presence_of(:referer_id) }
end
