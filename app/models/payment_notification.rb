# == Schema Information
#
# Table name: payment_notifications
#
#  id             :integer         not null, primary key
#  params         :text
#  user_id        :integer
#  status         :string(255)
#  transaction_id :string(255)
#  created_at     :datetime        not null
#  updated_at     :datetime        not null
#

class PaymentNotification < ActiveRecord::Base
  attr_accessible :params, :status, :transaction_id, :user_id
  belongs_to :user

  serialize :params
  after_create :update_user_purchased_at

  private

  def update_user_purchased_at
    if status == "Completed"
      user.update_attribute(:purchased_at, Time.now)
    end
  end

end
