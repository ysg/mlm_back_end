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

class User < ActiveRecord::Base
PACKAGE_IDS = { :platinum => 1, :gold => 2, :free => 3 }
PACKAGE_COSTS = { "1" => 299, "2" => 99, "3" => 0 }

has_many :payment_notifications

has_ancestry :cache_depth => true

attr_accessible :cell, :city, :company, :ein, :home_phone, :spouse_name, :state, :street_address, :zip
attr_protected :name, :email, :package, :referer_id

validates :name, presence:true
validates :email, presence:true, uniqueness:true
validates :street_address, presence: true
validates :city, presence: true
validates :state, presence: true
validates :zip, presence: true
validates :home_phone, presence: true
#validates :cell, allow_blank: true
validates :package, presence: true
validates :referer_id, presence: true

  def self.from_omniauth(auth,params)
   find_by_provider_and_uid(auth["provider"], auth["uid"]) || create_with_omniauth(auth,params)
  end

  def self.create_with_omniauth(auth,params)
   User.find_by_referer_id(params["referer_id"]).children.create! do |user|
     user.set_user_accessible_attributes(params)
     user.provider = auth["provider"]
     user.uid = auth["uid"]
     user.name = auth["info"]["name"]
     user.email = auth["info"]["email"]
     #default package is set to be 3. It gets updated on successful payment completion.
     user.package = (Rails.env == "development" ? params["package"] : "3")
     user.referer_id = User.generate_referer_id
     user.purchased_at = nil
   end
  end

  def set_associated_identity_attributes
    identity = Identity.find(self.uid)
    identity.email = self.email
    identity.name = self.name
    identity.set_associated_user_attributes
    identity.save
  end

  def set_user_accessible_attributes(params)
    accessible_attributes = User.accessible_attributes.to_a
    accessible_attributes.shift()
    accessible_attributes.each do |attr|
      self[attr.to_s] = params[attr] #if params[attr].present?
    end
  end

  def set_user_protected_attributes(params)
    self[:name] = params["name"] if params["name"].present?
    self[:email] = params["email"] if params["email"].present?
    self[:package] = params["package"] if params["package"].present?
    self[:referer_id] = params["referer_id"] if params["referer_id"].present?
  end

	def has_platinum_package
		package == PACKAGE_IDS[:platinum]
	end

	def has_gold_package
		package == PACKAGE_IDS[:gold]
	end

	def has_free_package
		package == PACKAGE_IDS[:free]
	end
	
	def first_generation
		children
	end

	def second_generation
		descendants(:at_depth => 2)
	end

	def network
		descendants.to_depth(2)
	end

	def current_earnings
		return 0 unless self.has_platinum_package
		earnings = 0
		first_generation.each do |user|
			earnings += self.earnings_from_user user
		end
		return earnings
	end

	def earnings_from_user(user)
		return 50 if (self.has_platinum_package) and (self.first_generation.include? user) and (user.has_platinum_package) 		
		return 0
	end

	def distance_from_user(user)
		return 0 unless self.descendants.include? user
		return user.depth - self.depth
  end

  def self.generate_referer_id
    Time.now.to_i.to_s[-6,6]
  end

  def paypal_url(return_url, notify_url, amount, upgrade_package=false)
    # custom_field : to determine the user to assign the payment, and update purchased package in PaymentNotifications#create

    #case of signup
    if upgrade_package == false
      signup_package = PACKAGE_IDS.key(PACKAGE_COSTS.key(amount).to_i).to_s

      package_name = signup_package+" Package"
      custom_field = "#{self.id}-#{signup_package}_package_signup"
    end

    if upgrade_package == "platinum"
      package_name = "platinum Package Upgrade"
      custom_field = "#{self.id}-platinum_package_upgrade"
    end

    if upgrade_package == "gold"
      package_name = "gold Package Upgrade"
      custom_field = "#{self.id}-gold_package_upgrade"
    end

    values = {
      :business => 'seller_1338452369_biz@gmail.com',
      :cmd => '_xclick',
      :return => return_url,
      :amount => amount,
      :item_name => package_name,
      :custom => custom_field,
      :notify_url => notify_url
    }
    "https://www.sandbox.paypal.com/cgi-bin/webscr?" + values.to_query
  end

  def update_identity
    identity = Identity.find(self.uid)
    identity.email = self.email
    identity.name = self.name
    identity.save(:validate => false)
  end








end
