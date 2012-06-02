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

class Identity < OmniAuth::Identity::Models::ActiveRecord
  USER_ATTRIBUTES = [:street_address, :city, :state, :zip, :home_phone, :cell, :package, :referred_by, :referer_id]

  attr_accessible :email, :name, :password_digest, :password, :password_confirmation, *USER_ATTRIBUTES
  attr_accessor *USER_ATTRIBUTES

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true, format: /^[^@\s]+\@([-a-z0-9]+\.)+[a-z0-9]{2,4}$/i
  validates :street_address, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :zip, presence: true
  validates :home_phone, numericality: true, presence: true
  validates :cell, numericality: true, presence: true
  validates :package, presence: true
  #validates :referred_by, presence: true
  validates :referer_id, presence: true


  def send_password_reset
    generate_token(:password_reset_token)
    self.password_reset_sent_at = Time.zone.now
    user = User.find_by_email_and_uid(self.email,self.id)
    self.package = user.package
    self.referer_id = user.referer_id
    save!
    UserMailer.password_reset(self).deliver
  end

  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while Identity.exists?(column => self[column])
  end
end
