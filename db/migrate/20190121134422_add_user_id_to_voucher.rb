class AddUserIdToVoucher < ActiveRecord::Migration[5.2]
  def change
    add_column :vouchers, :user_id, :integer
  end
end
