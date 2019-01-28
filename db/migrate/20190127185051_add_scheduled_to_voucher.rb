class AddScheduledToVoucher < ActiveRecord::Migration[5.2]
  def change
    add_column :vouchers, :scheduled, :boolean, default: false
  end
end
