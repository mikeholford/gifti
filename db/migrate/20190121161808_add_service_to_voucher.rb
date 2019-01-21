class AddServiceToVoucher < ActiveRecord::Migration[5.2]
  def change
    add_column :vouchers, :service, :string
  end
end
