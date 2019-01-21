class AddImageToVoucher < ActiveRecord::Migration[5.2]
  def change
    add_column :vouchers, :image, :string
  end
end
