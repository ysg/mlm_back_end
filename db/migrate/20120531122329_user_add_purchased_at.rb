class UserAddPurchasedAt < ActiveRecord::Migration
  def up
    add_column :users, :purchased_at, :datetime
  end

  def down
    remove_column :users, :purchased_at
  end
end
