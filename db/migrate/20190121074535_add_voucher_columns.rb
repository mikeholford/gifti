class AddVoucherColumns < ActiveRecord::Migration[5.2]
  def change
    add_column :vouchers, :from, :string
    add_column :vouchers, :send_at, :datetime
    add_column :vouchers, :message, :text
    add_column :vouchers, :design_id, :integer
  end
end
