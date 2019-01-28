class AddRefToVoucher < ActiveRecord::Migration[5.2]
  def change
    add_column :vouchers, :ref, :string
  end
end
