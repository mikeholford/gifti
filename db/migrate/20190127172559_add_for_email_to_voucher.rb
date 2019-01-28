class AddForEmailToVoucher < ActiveRecord::Migration[5.2]
  def change
    add_column :vouchers, :for_email, :string
  end
end
