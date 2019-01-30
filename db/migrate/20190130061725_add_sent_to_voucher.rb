class AddSentToVoucher < ActiveRecord::Migration[5.2]
  def change
    add_column :vouchers, :sent, :boolean, default: false
  end
end
